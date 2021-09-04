
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseville/Services/Listener.dart';
import 'package:courseville/Widgets/CourseVideoList.dart';
import 'package:courseville/Widgets/MoreeWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CourseVideoScreen extends StatefulWidget {

  QueryDocumentSnapshot queryDocumentSnapshot;
  int i;
  String user;


  CourseVideoScreen({this.queryDocumentSnapshot,this.i,this.user});

  @override
  _CourseVideoScreenState createState() => _CourseVideoScreenState();
}

class _CourseVideoScreenState extends State<CourseVideoScreen> {
  int currentVideoID = 0;
  bool _isPlayerReady = false;
  PlayerState playerState;
  final ktabs = <Tab>[Tab(child: Text("Lectures"),),Tab(child: Text("More"),),];
  List <Widget> kTabPages;
  YoutubePlayerController youtubePlayerController;
  Data provider;



  @override
  void initState(){
    super.initState();
    provider = Provider.of<Data>(context,listen: false);
WidgetsBinding.instance.addPostFrameCallback((_) {
  initiateCourseData().then((value) => null);
});
  }



  @override
  Widget build(BuildContext context) {

    youtubePlayerController = YoutubePlayerController(initialVideoId:
    widget.queryDocumentSnapshot.data()["coursevideo"][Provider.of<Data>(context,listen: false).videoID]["videoid"],
        flags: YoutubePlayerFlags(autoPlay: false, forceHD: true))..addListener(() {
          if(_isPlayerReady == true){
           playerState =  youtubePlayerController.value.playerState;
          }
    });

    kTabPages = <Widget>[CourseVideoList(
      queryDocumentSnapshot: widget.queryDocumentSnapshot,
      user: widget.user,
      courseIndex: widget.i,
      youtubePlayerController: youtubePlayerController,
    ),Column(children: [
      MorreWidget(queryDocumentSnapshot: widget.queryDocumentSnapshot,youtubePlayerController: youtubePlayerController,)
    ],)];



    return DefaultTabController(
      length: ktabs.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(height: MediaQuery.of(context).size.height * 0.3125),
                child: Consumer<Data>(
                  builder: (context,data,_){
                      youtubePlayerController.load(
                        widget.queryDocumentSnapshot.data()
                        ["coursevideo"][data.videoID]["videoid"],
                      );
                    return YoutubePlayer(
                      onReady: (){
                        _isPlayerReady = true;
                        print("reeeaaadddyyy");
                      }, controller: youtubePlayerController,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Color.fromARGB(255, 69, 22, 99),
                    );
                  },
                ),
              ),

            Padding(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(widget.queryDocumentSnapshot.data()["name"],
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600
                    ),),
                  SizedBox(height: 5,),
                  Text("Bryan Cairns",style: TextStyle(
                      color: Colors.grey[800]
                  ),),
                  SizedBox(height: 5,),

                  TabBar(
                    tabs:ktabs ,
                    labelColor: Colors.black,
                    indicatorColor: Color.fromARGB(255, 69, 22, 99),
                    indicatorSize: TabBarIndicatorSize.label,
                    labelStyle: TextStyle(
                      //   fontSize: 16
                    ),),

                  //SizedBox(height: 20,),


                ],
                ),
                padding: EdgeInsets.only(left: 15,right: 15,top: 15)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: TabBarView(
                    children: kTabPages,
                  ),
                ),
              )],
          )
        ),
      ),
    );
  }

  @override
  void deactivate() {
    youtubePlayerController.pause();
    super.deactivate();
  }

  @override
  void dispose() {
   youtubePlayerController.dispose();
   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  Future <void> initiateCourseData()async{
    var value = Provider.of<Data>(context,listen: false);
    Map<String,dynamic> courseNotification =  {"NotificationImage":widget.queryDocumentSnapshot.data()["image"],
      "NotificationMessage":"Hey ${provider.username}, you just started the course on ${widget.queryDocumentSnapshot.data()["name"]}",
      "NotificationName":DateTime.now().millisecondsSinceEpoch.toString(),
      "HasReadNotification": false};




            if(!provider.startedCourseNames.contains(widget.queryDocumentSnapshot.data()["name"])){
              value.addCourseResult(widget.i, (widget.queryDocumentSnapshot.data()["coursevideo"] as List).length);
              await FirebaseFirestore.instance.collection(widget.user).doc(widget.queryDocumentSnapshot.id).
              update({"hasStartedCourse": true}).then((value){
                provider.updateStartedCourseNames(widget.queryDocumentSnapshot.data()["name"]);
              });

              await FirebaseFirestore.instance.collection(widget.user).doc("Notifications").collection("Notifications").doc(
                  widget.queryDocumentSnapshot.id
              ).set(
                  {"NotificationImage": widget.queryDocumentSnapshot.data()["image"],
                    "NotificationMessage":"Hey ${provider.username}, You just Started the course on ${widget.queryDocumentSnapshot.data()["name"]}",
                    "NotificationName": DateTime.now().millisecondsSinceEpoch.toString(),
                    "HasReadNotification": false}).then((value) {
                provider.getNotifications(courseNotification);
                provider.getNotificationIDs(widget.queryDocumentSnapshot.id);
                provider.incrementNotificationCount();
              });
            }


    //print(Provider.of<Data>(context,listen: false).updatedCourseResult);

  }


}
