
import 'package:courseville/Services/Constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseville/Services/Listener.dart';
import 'package:courseville/Services/Utils.dart';
import 'package:courseville/Widgets/CourseVideoList.dart';
import 'package:courseville/Widgets/MoreeWidget.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ignore: must_be_immutable
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
  final kTabs = <Tab>[Tab(child: Text("Lectures"),),Tab(child: Text("More"),),];
  List <Widget> kTabPages;
  YoutubePlayerController youtubePlayerController;
  Data provider;
  var documentData;



  @override
  void initState(){
    super.initState();
    provider = Provider.of<Data>(context,listen: false);
    documentData = widget.queryDocumentSnapshot.data();
    if(documentData == null) return Utils().displayToast("An error occured");
    WidgetsBinding.instance.addPostFrameCallback((_) {
  initiateCourseData().then((value) => null);
});
  }



  @override
  Widget build(BuildContext context) {

    youtubePlayerController = YoutubePlayerController(initialVideoId:
    documentData[Constants.COURSE_VIDEO_DATA][provider.videoID]["videoid"],

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
      length: kTabs.length,
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
                       documentData[Constants.COURSE_VIDEO_DATA][data.videoID]["videoid"],
                      );
                    return YoutubePlayer(
                      onReady: (){
                        _isPlayerReady = true;
                      },
                      controller: youtubePlayerController,
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
                  Text(documentData[Constants.COURSE_NAME],
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600
                    ),),
                  SizedBox(height: 5,),
                  Text(documentData[Constants.COURSE_AUTHOR],style: TextStyle(
                      color: Colors.grey[800]
                  ),),
                  SizedBox(height: 5,),

                  TabBar(
                    tabs:kTabs ,
                    labelColor: Colors.black,
                    indicatorColor: Color.fromARGB(255, 69, 22, 99),
                    indicatorSize: TabBarIndicatorSize.label,
                    labelStyle: TextStyle(
                      //   fontSize: 16
                    ),),

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



  //Initiates course data when user starts a course

  //Creates a notification message and sends to firebase
  //Creates a list to show course progress
  Future <void> initiateCourseData()async{

    //create notification message
    Map<String,dynamic> courseNotification =  {"NotificationImage":documentData[Constants.COURSE_IMAGE],
      "NotificationMessage":"Hey ${provider.username}, you just started the course on ${documentData[Constants.COURSE_NAME]}",
      "NotificationName":DateTime.now().millisecondsSinceEpoch.toString(),
      "HasReadNotification": false};

        //checks if user has already started course before
        if(!provider.startedCourseNames.contains(documentData[Constants.COURSE_NAME])){

          //creates a list to show course progress
          provider.addCourseProgress(documentData[Constants.COURSE_NAME], documentData[Constants.COURSE_IMAGE],
              (documentData[Constants.COURSE_VIDEO_DATA] as List).length);

          await FirebaseFirestore.instance.collection(widget.user).doc(widget.queryDocumentSnapshot.id).
          update({Constants.COURSE_HAS_STARTED_COURSE: true}).then((value){
            provider.updateStartedCourseNames(documentData[Constants.COURSE_NAME]);
          });

        await FirebaseFirestore.instance.collection(widget.user).doc(Constants.NOTIFICATIONS).collection(Constants.NOTIFICATIONS).doc(
            widget.queryDocumentSnapshot.id).set(
            {"NotificationImage": documentData[Constants.COURSE_IMAGE],
              "NotificationMessage":"Hey ${provider.username}, You just Started the course on ${documentData[Constants.COURSE_NAME]}",
              "NotificationName": DateTime.now().millisecondsSinceEpoch.toString(),
              "HasReadNotification": false}).then((value) {

                provider.getNotifications(courseNotification);
                provider.getNotificationIDs(widget.queryDocumentSnapshot.id);
                provider.incrementNotificationCount();   //adds to number of notifications
              });
            }
  }

}
