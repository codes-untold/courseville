
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseville/Screens/CourseIntro.dart';
import 'package:courseville/Services/Constants.dart';
import 'package:courseville/Services/Listener.dart';
import 'package:courseville/Services/Utils.dart';
import 'package:courseville/Widgets/CourseListTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



// ignore: must_be_immutable
class CourseScreen extends StatefulWidget {

  QueryDocumentSnapshot queryDocumentSnapshot;
  String user;
  int courseScreenIndex;
  bool canHandleFavouriteOperations;

  CourseScreen({this.queryDocumentSnapshot,this.user,this.courseScreenIndex,this.canHandleFavouriteOperations});

  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {

  List <Widget> list = [];
  Color color;
  var providerData;


  @override
  void initState() {
    super.initState();

    for(Map<String,dynamic> lister in (widget.queryDocumentSnapshot.data()[Constants.COURSE_VIDEO_DATA] as List)){
      int i = 0;
      list?.add(CourselistTile(i: i,map: lister,queryDocumentSnapshot: widget.queryDocumentSnapshot,));
      i++;
    }

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    providerData = Provider.of<Data>(context,listen: false);
    if(providerData.favourite[widget.courseScreenIndex]){color = Colors.amber;}

    else{color = Colors.white;}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 15),
            child: Column(
              children: [
                Container(
                  child: Hero(
                    tag: widget.queryDocumentSnapshot.data()[Constants.COURSE_NAME],
                    child: CachedNetworkImage(
                      width: 250,
                      imageUrl: widget.queryDocumentSnapshot.data()[Constants.COURSE_IMAGE],
                      placeholder: (context,url) => Icon(Icons.auto_stories,size: MediaQuery.of(context).size.width *0.3,
                        color: Colors.black12,),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 18,right: 18),
                  child: Column(
                     mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(widget.queryDocumentSnapshot.data()[Constants.COURSE_AUTHOR] != null ?
                         "By ${widget.queryDocumentSnapshot.data()[Constants.COURSE_AUTHOR]}": "By Anonymous",
                            style: TextStyle(
                              // color: Colors.white
                            ),),

                          SizedBox(
                            width: 5,
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints.tightFor(height: 15,width: 15),
                            child: CircleAvatar(
                                backgroundImage: AssetImage("images/tutorimage.jpeg"),
                                radius:  MediaQuery.of(context).size.width * 0.1388,
                                backgroundColor: Colors.white
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Text(widget.queryDocumentSnapshot.data()[Constants.COURSE_NAME],
                          style: Constants.courseTextstyle2),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Row(children: [
                            Icon(
                              Icons.favorite,
                              color: Colors.amber,
                            ),
                            Text("2.1k",
                              style: Constants.courseTextstyle,)
                          ],),

                          SizedBox(width: 50,),
                          Row(children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            Text("4.8",
                              style: Constants.courseTextstyle,
                            )
                          ],),
                        ],
                      ),
                      SizedBox(height: 25,),
                      Text("About this course",
                          style: Constants.courseTextstyle3),

                      SizedBox(height: 12,),

                      Text(widget.queryDocumentSnapshot.data()[Constants.COURSE_DESCRIPTION],
                        style: Constants.courseTextstyle4,),
                      SizedBox(height: 25,),

                      Center(
                        child: Icon(Icons.arrow_drop_down_circle,
                          color: Color.fromARGB(255, 69, 22, 99),),
                      ),

                      SizedBox(height: 15,),


                     Column(
                        children: list
                      ),

                      SizedBox(height: 15,),

                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return CourseIntro(
                              queryDocumentSnapshot: widget.queryDocumentSnapshot,
                              courseIndex: widget.courseScreenIndex,
                              user: widget.user,
                            );
                          }));
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          color: Color(0xffa450f8),
                          child: Center(
                            child: Text("Get Started",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white
                              ),),
                          ),
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight:Radius.circular(30))
                  ),
                )
              ],
            ),
          ),
        )
      ),

   floatingActionButton: Visibility(
     visible: widget.canHandleFavouriteOperations,
     child: Consumer<Data>(
       builder: (context,data,_){
         return FloatingActionButton(
           onPressed: (){ clickFavourite(context, data);},
           backgroundColor: Color.fromARGB(255, 69, 22, 99),
           child: Icon(Icons.favorite,
             color: color,),
         );
       },

     ),
   ), );
  }

  //Handles operation when floating action button is clicked
  clickFavourite(BuildContext context ,Data data) async{
    if(data.favourite[widget.courseScreenIndex]){
      color = Colors.white;
      data.updateFavouriteList(widget.courseScreenIndex, false);
      Utils().showInSnackBar("${widget.queryDocumentSnapshot.data()[Constants.COURSE_NAME]} Removed from Favourites•☹️",context);
      await FirebaseFirestore.instance.collection(widget.user).doc(widget.queryDocumentSnapshot.id).update({"favourite": false});
    }

    else{
      color = Colors.amber;
      data.updateFavouriteList(widget.courseScreenIndex, true);
      Utils().showInSnackBar("${widget.queryDocumentSnapshot.data()[Constants.COURSE_NAME]} Added to Favourites😀",context);
      await FirebaseFirestore.instance.collection(widget.user).doc((widget.queryDocumentSnapshot.id)).update({"favourite": true});
    }
  }
}

