import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseville/Services/Listener.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CourseFetch{

  List <Map<String,dynamic>> list = [];
  List <Map<String,dynamic>> searchList = [];
  bool state;
  List <QueryDocumentSnapshot> lister = [];
  List <bool> favList = [];
  List boolList = [];
  List courseNames = [];

  Future <List <QueryDocumentSnapshot>> generalFetch(String user,BuildContext context)async{
      var value =   Provider.of<Data>(context,listen: false);
   await FirebaseFirestore.instance.collection(user).get().then((querySnapshot){
     boolList.clear();
     querySnapshot.docs.forEach((element) {
       if(element.data()["name"]!= null){

         lister.add(element);
         favList.add(element.data()["favourite"]);
         boolList.add(element.data()["coursevideo"]);
          courseNames.add(element.data()["name"]);

       }

     });

     value.addFavouriteList(favList);
     value.addCourseBoolState(boolList);
     value.addCourseNames(courseNames);
     value.getResults(lister);

    });
   return lister;
  }

  Future <List <QueryDocumentSnapshot>> popularFetch(String user,BuildContext context)async{
    var value =   Provider.of<Data>(context,listen: false);
    await FirebaseFirestore.instance.collection(user).where("category",isEqualTo: "popular").get().then((querySnapshot){
      list.clear();

      querySnapshot.docs.forEach((element) {
        lister.add(element);
        favList.add(element.data()["favourite"]);
        boolList.add(element.data()["coursevideo"]);
        courseNames.add(element.data()["names"]);


      });
      print(favList);
      value.addFavouriteList(favList);
      value.addCourseBoolState(boolList);
      value.addCourseNames(courseNames);
    });
    return lister;
  }

  Future <List <QueryDocumentSnapshot>> topFetch(String user,BuildContext context)async{
    var value =   Provider.of<Data>(context,listen: false);
    await FirebaseFirestore.instance.collection(user).where("category",isEqualTo: "Top").get().then((querySnapshot){
      list.clear();
      querySnapshot.docs.forEach((element) {
        lister.add(element);
        favList.add(element.data()["favourite"]);
        boolList.add(element.data()["coursevideo"]);
        courseNames.add(element.data()["names"]);


      });
      print(favList);
      value.addFavouriteList(favList);
      value.addCourseBoolState(boolList);
      value.addCourseNames(courseNames);
    });
    return lister;
  }

  Future <List <QueryDocumentSnapshot>> searchFetch(String user,String search,BuildContext context)async{

    await FirebaseFirestore.instance.collection(user).get().then((querySnapshot){
      var value =   Provider.of<Data>(context,listen: false);
      querySnapshot.docs.forEach((element) {
        if(element.data()["name"]!= null){

          lister.add(element);

        }

      });

     lister.removeWhere((element) {
       String data = (element.data()["name"]);


       if(!(data.toLowerCase().contains(search.toLowerCase())))
         {

           return true;
         }
       else{
         favList.add(element.data()["favourite"]);
         boolList.add(element.data()["coursevideo"]);
         courseNames.add(element.data()["names"]);

         return false;
       }
     });

      print(favList);
      value.addFavouriteList(favList);
      value.addCourseBoolState(boolList);
      value.addCourseNames(courseNames);
    });
    return lister;
  }
}