
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseville/Services/Constants.dart';
import 'package:courseville/Services/Listener.dart';
import 'package:courseville/Widgets/CongratsWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ignore: must_be_immutable
class VideoScreenListTile extends StatefulWidget {

  QueryDocumentSnapshot queryDocumentSnapshot;
  int videoIndex,courseIndex;
  String user;
  YoutubePlayerController youtubePlayerController;

  VideoScreenListTile({this.queryDocumentSnapshot,this.videoIndex,this.courseIndex,this.user,
  this.youtubePlayerController});

  static const menuItems = <String>["Mark as Complete","Mark as Incomplete"];


  @override
  _VideoScreenListTileState createState() => _VideoScreenListTileState();
}

class _VideoScreenListTileState extends State<VideoScreenListTile> {

  List <dynamic> list,list2;
  List <bool> boolList = [];
  List <dynamic> map;
  Data provider;
  bool isComplete = false;
  bool totalCompletion = false;
  var documentData;


  final List <PopupMenuItem<String>> _popUpMenuItems = VideoScreenListTile.menuItems.map((String value) => PopupMenuItem<String>(
    value: value,
    child: Text(value),
  )).toList();


  @override
  void initState() {
    super.initState();
    provider =  Provider.of<Data>(context,listen: false);
    documentData = widget.queryDocumentSnapshot.data();
    list = documentData["coursevideo"];
    list2 = documentData ["coursevideo"];
    List <dynamic> map = provider.courseVideoList[widget.courseIndex];
    isComplete = map[widget.videoIndex]["iscomplete"];

  }
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left: 8,right: 8),
      child: Consumer<Data>(
        builder: (context,data,_){
          return ListTile(
            onTap: (){
              data.updateCurrentVideoID(widget.videoIndex);

            },
            horizontalTitleGap: 1,
            selected: widget.videoIndex == data.videoID ? true:false,
            selectedTileColor:  Color.fromARGB(255, 221, 212, 226),
            leading:   Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text((widget.videoIndex+1).toString(),
                style: TextStyle(
                  fontSize: 13,
                ),),
            ),
            trailing: PopupMenuButton(
            itemBuilder: (BuildContext context)=> _popUpMenuItems,
              onSelected: (String value)async{
              popMenuButtonChange(value);
              updateCourseProgress(value);
              },

            ),
            title:Row(
              children: [
                Flexible(
                  child: Text(documentData["coursevideo"][widget.videoIndex]["videoname"],

                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14
                      ),),
                ),

                SizedBox(width: 5,),
                Visibility(
                  visible: isComplete,
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 69, 22, 99),
                      radius: 10,
                      child: Icon(Icons.check,size: 12,color: Colors.white,)),
                ),
              ],
            ),
            subtitle:  Text("video ${documentData["coursevideo"][widget.videoIndex]["videotime"]}",
              style: TextStyle(
                  fontSize: 10
              ),) ,
          );
        },

      )
    );
  }

  //notifies Data class about users course progress
  List <bool> notifyCourseProgress(List courseContentList){
    List <bool> updatedCourseProgress = [];
    int totalCompletionCount = 0;
    for(int i = 0;i < courseContentList.length;i++){
      updatedCourseProgress.add(courseContentList[i]["iscomplete"]);

      //check for number of videos that are marked as complete
      //increment totalCompletionCount for each completed video
      if(courseContentList[i]["iscomplete"]){
        totalCompletionCount++;
      }
    }

    //when totalCompletionCount equals total length of coursecontent
    //it means user has marked all video as complete
    if(totalCompletionCount == courseContentList.length){
      totalCompletion = true;
      dialogFunction(context);  //shows congratulatory message as a pop up

      //Check if user has completed course previously to avoid recording
      //as complete multiple times
      if(!documentData[Constants.COURSE_HAS_ENDED_COURSE]) {
        updateCourseCompletion();
        provider.updateCompletedCoursesList(widget.queryDocumentSnapshot);
      }
      Future.delayed(Duration(seconds: 2),(){
        widget.youtubePlayerController.pause();
      });
    }
    return updatedCourseProgress;  //returns current progress of course as a list
  }

  //pop up dialog called when user successfully completed course
  dialogFunction(BuildContext context){
    showDialog(context: context, builder: (context){
      return Dialog(
        elevation: 16,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: CongratsWidget(coursename: documentData["name"],
          username: provider.username,),

        ),
      );
    });
  }


  //handles all operations when user successfully completed course

  //Creates a notification message and sends to firebase
  // notifies provider class about completion of course
  void updateCourseCompletion()async{
    Map<String,dynamic> courseNotification =  {"NotificationImage": documentData[Constants.COURSE_IMAGE],
      "NotificationMessage":"Great Job ${provider.username}, you just completed the course on ${documentData[Constants.COURSE_NAME]}",
      "NotificationName":DateTime.now().millisecondsSinceEpoch.toString(),
      "HasReadNotification": false};

    await FirebaseFirestore.instance.collection(widget.user).doc(widget.queryDocumentSnapshot.id).
    update({"hasEndedCourse": true}).then((value)async{

      await FirebaseFirestore.instance.collection(widget.user).doc("Notifications").collection("Notifications").doc(
          "${widget.queryDocumentSnapshot.id}complete").set(
          {"NotificationImage": documentData[Constants.COURSE_IMAGE],
            "NotificationMessage":"Good job ${provider.username}!, "
                "You have successfully completed the course on ${documentData[Constants.COURSE_NAME]}",
            "NotificationName": DateTime.now().millisecondsSinceEpoch.toString(),
            "HasReadNotification": false}).then((value) {

        provider.getNotifications(courseNotification);
        provider.getNotificationIDs(widget.queryDocumentSnapshot.id);
        provider.incrementNotificationCount();

      });
    });
  }

  //handles change of button state upon click of pop menu buttons
  void popMenuButtonChange(value){
    if(value == "Mark as Complete"){
      setState(()=> isComplete = true);
    }else{
      setState(()=> isComplete = false);
    }

  }

  //handles all operations when user marks/unmarks a video

  //notifies user document on firebase about course progress
  //notifies provider class about course progress
  void updateCourseProgress(value)async{
    Map<String,dynamic> courseContent = {
      "videoname":list2[widget.videoIndex]["videoname"],
      "videotime":list2[widget.videoIndex]["videotime"],
      "videoid":list2[widget.videoIndex]["videoid"],
      "iscomplete": isComplete,
      "id": widget.videoIndex + 1,
    };


    await FirebaseFirestore.instance.collection(widget.user).
    where("name",isEqualTo: documentData['name'],
    ).get().then((QuerySnapshot value){
      value.docs.forEach((element) {
        list = (element.data()["coursevideo"]);
        list2 = (element.data()["coursevideo"]);
      });
    });

    if(widget.videoIndex == list.length - 1){
      list.removeAt(widget.videoIndex);
      list.add(courseContent);
    }
    else{
      list.removeAt(widget.videoIndex);
      list.insert(widget.videoIndex, courseContent);
    }

    provider.updateCourseProgress(documentData["name"], notifyCourseProgress(list));

    await FirebaseFirestore.instance.collection(widget.user).doc(widget.queryDocumentSnapshot.id).
    update({"coursevideo": list}).then((value){
      provider.updateCourseVideoListData(list, widget.courseIndex);
    });
  }
}
