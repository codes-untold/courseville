
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseville/Services/Listener.dart';
import 'package:courseville/Widgets/CongratsWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreenListTile extends StatefulWidget {

  QueryDocumentSnapshot queryDocumentSnapshot;
  int videoindex,courseindex;
  String user;
  YoutubePlayerController youtubePlayerController;

  VideoScreenListTile({this.queryDocumentSnapshot,this.videoindex,this.courseindex,this.user,
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


  final List <PopupMenuItem<String>> _popUpMenuItems = VideoScreenListTile.menuItems.map((String value) => PopupMenuItem<String>(
    value: value,
    child: Text(value),
  )).toList();


  @override
  void initState() {
    super.initState();
    provider =   Provider.of<Data>(context,listen: false);
    list = widget.queryDocumentSnapshot.data()["coursevideo"];
    list2 = widget.queryDocumentSnapshot.data()["coursevideo"];
    List <dynamic> map = provider.isCourseComplete[widget.courseindex];
    isComplete = map[widget.videoindex]["iscomplete"];

  }
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left: 8,right: 8),
      child: Consumer<Data>(
        builder: (context,data,_){
          return ListTile(
            onTap: (){
              data.updateCurrentVideoID(widget.videoindex);

            },
            horizontalTitleGap: 1,
            selected: widget.videoindex == data.videoID ? true:false,
            selectedTileColor:  Color.fromARGB(255, 221, 212, 226),
            leading:   Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text((widget.videoindex+1).toString(),
                style: TextStyle(
                  fontSize: 13,
                ),),
            ),
            trailing: PopupMenuButton(
            itemBuilder: (BuildContext context)=> _popUpMenuItems,
              onSelected: (String value)async{

              if(value == "Mark as Complete"){
               setState(()=> isComplete = true);
              }else{
                setState(()=> isComplete = false);
              }


              await FirebaseFirestore.instance.collection(widget.user).
              where("name",isEqualTo:widget.queryDocumentSnapshot.data()['name'],
                ).get().then((QuerySnapshot value){
                 value.docs.forEach((element) {
                 list = (element.data()["coursevideo"]);
                 list2 = (element.data()["coursevideo"]);
                 });
              });

              Map<String,dynamic> courseContent = {
                "videoname":list2[widget.videoindex]["videoname"],
                "videotime":list2[widget.videoindex]["videotime"],
                "videoid":list2[widget.videoindex]["videoid"],
                "iscomplete": isComplete,
                "id": widget.videoindex + 1,
              };

              if(widget.videoindex == list.length - 1){
                list.removeAt(widget.videoindex);

                list.add(courseContent);
              }
              else{
                list.removeAt(widget.videoindex);
                list.insert(widget.videoindex, courseContent);
              }

              provider.updateCourseResult(
                  widget.queryDocumentSnapshot.data()["name"], notifyCourseProgress(list));

              await FirebaseFirestore.instance.collection(widget.user).doc(widget.queryDocumentSnapshot.id).
              update({"coursevideo": list}).then((value){
                provider.updateCourseBoolState(list, widget.courseindex);
                print("success");

              });
              },

            ),
            title:Row(
              children: [
                Flexible(
                  child: Text(widget.queryDocumentSnapshot.data()["coursevideo"][widget.videoindex]["videoname"],

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
            subtitle:  Text("video ${widget.queryDocumentSnapshot.data()["coursevideo"][widget.videoindex]["videotime"]}",
              style: TextStyle(
                  fontSize: 10
              ),) ,
          );
        },

      )
    );
  }

  List <bool> notifyCourseProgress(List courseContentList){
    List <bool> updatedCourseProgress = [];
    int totalCompletionCount = 0;
    for(int i = 0;i < courseContentList.length;i++){

      updatedCourseProgress.add(courseContentList[i]["iscomplete"]);
      if(courseContentList[i]["iscomplete"]){
        totalCompletionCount++;
      }


    }
    if(totalCompletionCount == courseContentList.length){
      totalCompletion = true;
      dialogFunction(context);
      if(!widget.queryDocumentSnapshot.data()["hasEndedCourse"]) {
        updateCourseCompletion();
        provider.addCompletedCourses(widget.queryDocumentSnapshot);
      }
      Future.delayed(Duration(seconds: 2),(){
        widget.youtubePlayerController.pause();
      });


    }
    return updatedCourseProgress;
  }

  dialogFunction(BuildContext context){
    showDialog(context: context, builder: (context){
      return Dialog(
        elevation: 16,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: CongratsWidget(coursename: widget.queryDocumentSnapshot.data()["name"],
          username: provider.username,),

        ),
      );
    });
  }

  void updateCourseCompletion()async{

    Map<String,dynamic> courseNotification =  {"NotificationImage":widget.queryDocumentSnapshot.data()["image"],
      "NotificationMessage":"Great Job ${provider.username}, you just completed the course on ${widget.queryDocumentSnapshot.data()["name"]}",
      "NotificationName":DateTime.now().millisecondsSinceEpoch.toString(),
      "HasReadNotification": false};

    await FirebaseFirestore.instance.collection(widget.user).doc(widget.queryDocumentSnapshot.id).
    update({"hasEndedCourse": true}).then((value)async{

      await FirebaseFirestore.instance.collection(widget.user).doc("Notifications").collection("Notifications").doc(
          "${widget.queryDocumentSnapshot.id}complete"
      ).set(
          {"NotificationImage": widget.queryDocumentSnapshot.data()["image"],
            "NotificationMessage":"Good job ${provider.username}!, You have successfully completed the course on ${widget.queryDocumentSnapshot.data()["name"]}",
            "NotificationName": DateTime.now().millisecondsSinceEpoch.toString(),
            "HasReadNotification": false}).then((value) {
        provider.getNotifications(courseNotification);
        provider.getNotificationIDs(widget.queryDocumentSnapshot.id);
        provider.incrementNotificationCount();

      });
    });
  }
}
