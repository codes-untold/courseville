
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Data extends ChangeNotifier{


  String username;
  User userInfo;
  String searchTerm;
  List <bool> favourite= [];
  int videoID =0;
  List isCourseComplete = [];
  List courseNames = [];
  List courseImages= [];
  List generalList = [];
  int notificationCount = 0;
  List<Map<String,dynamic>> updatedCourseResult = [];
  List<Map<String,dynamic>> completedCourses = [];
  List<Map<String,dynamic>> notifications = [];
  List <String> notificationIDs = [];
  List <String> startedCourseNames = [];




  void updateText(String text){
    username = text;
    notifyListeners();
  }

  void updateStartedCourseNames(String name){
    startedCourseNames.add(name);
    notifyListeners();
  }

  void getStartedCourseNames(List <QueryDocumentSnapshot> list){
    for(int i = 0; i < list.length;i++){
      if(list[i].data()["hasStartedCourse"]){
        startedCourseNames.add(list[i].data()["name"]);
      }
    }

    notifyListeners();
  }


  void incrementNotificationCount(){
    notificationCount++;
    notifyListeners();
    print(notificationCount);
  }

  void resetNotificationCount(){
    notificationCount = 0;
    notifyListeners();
  }

  void updateUser(User user){
    userInfo = user;
    notifyListeners();
  }

  void addFavouriteList(List fav){
    favourite = fav;
    notifyListeners();

  }

  void UpdateFavouriteList(int index,bool value){
    favourite[index] = value;
    notifyListeners();
  }

  void updateCurrentVideoID(int value){
    videoID = value;
    notifyListeners();

  }

  void addCourseBoolState(List list){
    isCourseComplete = list;
    notifyListeners();
  }

  void updateCourseBoolState(List list,int index){
    isCourseComplete[index] = list;
    notifyListeners();
  }

  void addCourseNames(List list){
    courseNames = list;
    notifyListeners();

  }

  void addCourseImages(List list){
    courseImages = list;
    notifyListeners();
  }

  void addCourseResult(String name,String image,int length){
    updatedCourseResult.add({
      "coursename": name,
      "courseimage": image,
      "courseprogress": fillBoolState(length)
    });
    notifyListeners();

  }

  void addCertificates(String name){
    for(int i = 0;i < updatedCourseResult.length;i++){
      if(updatedCourseResult[i].containsValue(name)){
       completedCourses.add(updatedCourseResult[i]);
      }
    }

    notifyListeners();
  }

  void updateCourseResult(String name,List <bool> list){

    for(int i = 0;i < updatedCourseResult.length;i++){
      if(updatedCourseResult[i].containsValue(name)){
        updatedCourseResult[i]..update("courseprogress", (value) => list);
      }
    }
    notifyListeners();

  }

  void addCompletedCourses(QueryDocumentSnapshot queryDocumentSnapshot){

    if(completedCourses.isEmpty){
      completedCourses.add({
      "coursename": queryDocumentSnapshot.data()["name"],
      "courseimage": queryDocumentSnapshot.data()["image"],
      "courseprogress": queryDocumentSnapshot.data()["coursevideo"]
      });
    }

    else{
      for(int i = 0;i < updatedCourseResult.length;i++){
        if(updatedCourseResult[i].containsValue(queryDocumentSnapshot.data()["name"])){
          completedCourses.add(updatedCourseResult[i]);
        }
      }
    }
    notifyListeners();
  }

  List <bool> fillBoolState(int length){
    List <bool> _list = [];
    for(int i = 0;i < length;i++){
      _list.add(false);   //Creates course with initial video progress all set to false
    }
    return _list;
  }

  List <bool> loopBoolList(List list){
    List<bool> sth = [];
    for(int i = 0;i < list.length; i++ ){
      sth.add(list[i]["iscomplete"]);
    }
    return sth;
  }

  void getResults(List <QueryDocumentSnapshot> list){
    if(updatedCourseResult.isEmpty){
      for(int i = 0; i < list.length;i++){
        if(list[i].data()["hasStartedCourse"]){
          updatedCourseResult.add({
            "coursename": list[i].data()["name"],
            "courseimage": list[i].data()["image"],
            "courseprogress": loopBoolList(list[i].data()["coursevideo"])
          });
        }
      }
    }
    notifyListeners();
  }

  void getCompletedCourses(List <QueryDocumentSnapshot> list){
      for(int i = 0; i < list.length;i++){
        if(list[i].data()["hasEndedCourse"]){
          completedCourses.add({
            "coursename": list[i].data()["name"],
            "courseimage": list[i].data()["image"],
            "courseprogress": loopBoolList(list[i].data()["coursevideo"])
          });
        }
      }

    notifyListeners();
  }

  void getNotifications(Map<String,dynamic> map){
    notifications.insert(0, map);
    notifyListeners();
  }

  void getNotificationIDs(String value){
    notificationIDs.insert(0, value);
    notifyListeners();
  }
}