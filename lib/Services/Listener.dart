
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseville/Services/Constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


//The class is the brain of the entire app

//It listens for changes in different areas of the app
//It listens for new notifications,started courses,completed courses,
//
class Data extends ChangeNotifier{


  String username;
  User userInfo;
  String searchTerm;
  List <bool> favourite= [];
  int videoID =0;
  List courseVideoList = [];                                 //List of course video data one for each course
  List generalList = [];                                      //List of all course documents from as querydocumentsnapshots
  int notificationCount = 0;                                  //a Counter for number of unread notifications
  List<Map<String,dynamic>> updatedCourseProgress = [];       //List of updated course progress for all courses
  List<Map<String,dynamic>> completedCourses = [];           //List of completed courses as maps
  List<Map<String,dynamic>> notifications = [];              //List of Notifications as maps from Firebase
  List <String> notificationIDs = [];                        //List of notificationIDs from firebase
  List <String> startedCourseNames = [];                     //List of courses which the user has started



  //updates the display username to be used across entire app
  void updateText(String text){
    username = text;
    notifyListeners();
  }

  //Adds a new course name to the list when user
  //starts the course
  void updateStartedCourseNames(String name){
    startedCourseNames.add(name);
    notifyListeners();
  }

  //Loops through list of querysnapshots and gets only the names
  //of courses that have been started by user
  void getStartedCourseNames(List <QueryDocumentSnapshot> list){
    for(int i = 0; i < list.length;i++){
      if(list[i].data()[Constants.COURSE_HAS_STARTED_COURSE]){
        startedCourseNames.add(list[i].data()[Constants.COURSE_NAME]);
      }
    }

    notifyListeners();
  }

    //Increment the notification counter when there
   //is a new notification
  void incrementNotificationCount(){
    notificationCount++;
    notifyListeners();
    print(notificationCount);
  }

  //Reset notification counter when user reads
  // all notifications
  void resetNotificationCount(){
    notificationCount = 0;
    notifyListeners();
  }

  //Get firebase user and assigns it to "userinfo"
  //when logging into app
  void getFirebaseUser(User user){
    userInfo = user;
    notifyListeners();
  }

  //Get list of booleans for each course showing if course
  //is marked as favourite or not
  void addFavouriteList(List fav){
    favourite = fav;
    notifyListeners();

  }

  //updates the list of favourites when user adds or
  //removes a course from favourites
  void updateFavouriteList(int index,bool value){
    favourite[index] = value;
    notifyListeners();
  }

  //Update the video of a course video when user clicks on a
  //new video
  void updateCurrentVideoID(int value){
    videoID = value;
    notifyListeners();

  }

  //gets the "coursevideo" field for each course
  // and assigns it to variable courseVideoList
  void getCourseVideoList(List list){
    courseVideoList = list;
    notifyListeners();
  }


  //updates the coursevideolist when user marks any course as complete
  //or unmarks any course
  void updateCourseVideoListData(List list,int index){
    courseVideoList [index] = list;
    notifyListeners();
  }


  //adds a map  to variable "updatedCourseProgress"
  //when user begins a course

  //The "courseprogress" key of the map is updated
  //when user marks or unmarks a course video
  void addCourseProgress(String name,String image,int length){
    updatedCourseProgress.add({
      "coursename": name,
      "courseimage": image,
      "courseprogress": setCourseVideoToFalse(length)
    });
    notifyListeners();

  }

  //Adds a map to variable "completed courses" when
  //user completely finishes a course
  void addCertificates(String name){
    for(int i = 0;i < updatedCourseProgress.length;i++){
      if(updatedCourseProgress[i].containsValue(name)){
       completedCourses.add(updatedCourseProgress[i]);
      }
    }

    notifyListeners();
  }

  //Updates variable "updatedCourseProgress" when user
  //marks or unmarks a course video
  void updateCourseProgress(String name,List <bool> list){

    for(int i = 0;i < updatedCourseProgress.length;i++){
      if(updatedCourseProgress[i].containsValue(name)){
        updatedCourseProgress[i]..update("courseprogress", (value) => list);
      }
    }
    notifyListeners();
  }

  //Adds new maps to the variable "completed courses" as user completes
  //more courses
  void updateCompletedCoursesList(QueryDocumentSnapshot queryDocumentSnapshot){
    if(completedCourses.isEmpty){
      completedCourses.add({
      "coursename": queryDocumentSnapshot.data()[Constants.COURSE_NAME],
      "courseimage": queryDocumentSnapshot.data()[Constants.COURSE_IMAGE],
      "courseprogress": queryDocumentSnapshot.data()[Constants.COURSE_VIDEO_DATA]
      });
    }

    else{
      for(int i = 0;i < updatedCourseProgress.length;i++){
        if(updatedCourseProgress[i].containsValue(queryDocumentSnapshot.data()[Constants.COURSE_NAME])){
          completedCourses.add(updatedCourseProgress[i]);
        }
      }
    }
    notifyListeners();
  }

  //Sets all course videos as false (unmarked) when user starts
  // a course
  List <bool> setCourseVideoToFalse(int length){
    List <bool> _list = [];
    for(int i = 0;i < length;i++){
      _list.add(false);   //Creates course with initial video progress all set to false
    }
    return _list;
  }


  //creates a list and assigns all the "incomplete" fields
  //of maps to the list
  List <bool> loopThroughBoolList(List list){
    List<bool> boolList = [];
    for(int i = 0;i < list.length; i++ ){
      boolList.add(list[i]["iscomplete"]);
    }
    return boolList;
  }

  //Adds started courses to variable updatedCourseProgress
  void getResults(List <QueryDocumentSnapshot> list){
    if(updatedCourseProgress.isEmpty){
      for(int i = 0; i < list.length;i++){
        if(list[i].data()[Constants.COURSE_HAS_STARTED_COURSE]){
          updatedCourseProgress.add({
            "coursename": list[i].data()[Constants.COURSE_NAME],
            "courseimage": list[i].data()[Constants.COURSE_IMAGE],
            "courseprogress": loopThroughBoolList(list[i].data()[Constants.COURSE_VIDEO_DATA])
          });
        }
      }
    }
    notifyListeners();
  }

  //Adds completed courses courses to variable "completed courses"
  void getCompletedCourses(List <QueryDocumentSnapshot> list){
      for(int i = 0; i < list.length;i++){
        if(list[i].data()["hasEndedCourse"]){
          completedCourses.add({
            "coursename": list[i].data()["name"],
            "courseimage": list[i].data()["image"],
            "courseprogress": loopThroughBoolList(list[i].data()["coursevideo"])
          });
        }
      }

    notifyListeners();
  }


  //gets the notification messages and assigns them to
  //variable "notifications"
  void getNotifications(Map<String,dynamic> map){
    notifications.insert(0, map);
    notifyListeners();
  }

  //gets the user document ID of the notification messages and
  // assigns them to variable "notificationIDs"
  void getNotificationIDs(String value){
    notificationIDs.insert(0, value);
    notifyListeners();
  }
}