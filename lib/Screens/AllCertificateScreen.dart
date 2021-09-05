import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:courseville/Services/Listener.dart';
import 'package:courseville/Services/Utils.dart';
import 'package:courseville/Widgets/Certificate.dart';
import 'package:courseville/Widgets/WidgetToImage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../Services.dart';

class AllCertificateScreen extends StatefulWidget {



  @override
  _AllCertificateScreenState createState() => _AllCertificateScreenState();
}

class _AllCertificateScreenState extends State<AllCertificateScreen> {
  PageController _pageController;
  int prevPage;
  String user;
  Data provider;
  int numberOfCourses;
  int courseIndex = 0;
  GlobalKey key1;
  Uint8List bytes1;
  Services services = Services();
  double screenHeight,screenWidth;



  void _onScroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
      setState(() {courseIndex = _pageController.page.toInt();});
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8)..addListener(_onScroll);
    provider = Provider.of<Data>(context,listen: false);
    numberOfCourses = provider.completedCourses.length;
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[300],
        body: Stack(
          children: <Widget>[
            Container(
              height: screenHeight- 50.0,
              width: screenWidth,
              child: Center(child: WidgetToImage(
                builder: (key){
                  this.key1 = key;
                  return Certificate(
                    username:provider.username,
                    coursename: provider.completedCourses[courseIndex]["coursename"],);
                },

              ),),
            ),
            Positioned(
              bottom: 20.0,
              child: Container(
                height: 200.0,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: numberOfCourses,
                  itemBuilder: (BuildContext context, int index) {
                   // courseIndex = index;
                    //print(index);
                    return _certificateList(index);
                  },
                ),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
        onPressed:()async{
    bool isPermitted = await Permission.storage.isGranted;
    if(isPermitted)exportCertificate();
    else{
    await Permission.storage.request().then((value) => exportCertificate());
    }

    },
    backgroundColor: Color.fromARGB(255, 69, 22, 99),
    child: Icon(Icons.download_sharp,
    color: Colors.white),
    ));
  }

  _certificateList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
          onTap: () {
            // moveCamera();
          },
          child: Stack(children: [
            Center(
                child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 20.0,
                    ),
                    height: 125.0,
                    width: 275.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 10.0,
                          ),
                        ]),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16.0),topLeft: Radius.circular(16.0)),
                            child: CachedNetworkImage(
                              imageUrl: provider.completedCourses[index]["courseimage"],
                              placeholder: (context,url) => Icon(Icons.auto_stories,size: screenWidth *0.3,
                                color: Colors.black12,),
                            ),
                          ),
                          SizedBox(width: 5.0),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                   provider.completedCourses[index]["coursename"],style: (
                                    TextStyle(
                                      fontWeight: FontWeight.w700
                                    )
                                    ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                             Text("${ (provider.completedCourses[index]["courseprogress"] as List).length} videos",style: TextStyle(
                               fontSize: 12
                             ),)
                                  ]),
                            ),
                          )
                        ]))))
          ])),
    );
  }


  void exportCertificate()async{
    final bytes1 = await Utils.capture(key1);

    Directory documentDirectory = await getExternalStorageDirectory();
    new Directory(documentDirectory.path).create(recursive: true).then((Directory directory) async{
      File file = await new File("${directory.path}/${ provider.completedCourses[courseIndex]["coursename"]}.jpg").create(recursive: true);
      await file.writeAsBytes(bytes1).then((value) {
        services.displayToast("Saved to ${directory.path}/");
      }).onError((error, stackTrace){ services.displayToast("An error occured");});

    });

  }
}
