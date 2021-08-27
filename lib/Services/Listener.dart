
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Data extends ChangeNotifier{


  String auth;
  User userInfo;
  String searchTerm;
  List <bool> favourite;
  int videoID =0;
  List isCourseComplete = [];
  List courseNames = [];
  List generalList = [];
  List<Map<String,dynamic>> updatedCourseResult = [];



  void updateText(String text){
    auth = text;

    notifyListeners();
  }

  void updateUser(User user){
    userInfo = user;
    notifyListeners();
  }

void updateSearch(String search){
    searchTerm = search;
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

  void addCourseResult(int index,int length){
    updatedCourseResult.add({
      "coursename": courseNames[index],
      "courseprogress": fillBoolState(length)
    });
    notifyListeners();
  }

  void updateCourseResult(String name,List <bool> list){

    for(int i = 0;i < updatedCourseResult.length;i++){
      if(updatedCourseResult[i].containsValue(name)){
        updatedCourseResult[i]..update("courseprogress", (value) => list);
      }
    }
    notifyListeners();
    print(updatedCourseResult);
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
    for(int i = 0; i < list.length;i++){
      if(list[i].data()["hasStartedCourse"]){
        updatedCourseResult.add({
          "coursename": list[i].data()["name"],
          "courseprogress": loopBoolList(list[i].data()["coursevideo"])
        });
      }
    }
    print(updatedCourseResult);
    notifyListeners();
  }
}