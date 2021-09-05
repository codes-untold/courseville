import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseville/Services/Listener.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CourseFetch{


  List <Map<String,dynamic>> searchList = [];
  List <QueryDocumentSnapshot> listOfDocuments  = [];
  List <bool> favList = [];
  List boolList = [];
  List courseNames = [];
  List courseImages = [];

  Future <List <QueryDocumentSnapshot>> generalFetch(String user,BuildContext context)async{
      var value =   Provider.of<Data>(context,listen: false);
    await FirebaseFirestore.instance.collection(user).get().then((querySnapshot){
     boolList.clear();

     querySnapshot.docs.forEach((element) {
       if(element.data()["name"]!= null){
         getData(element);
       }

     });
     sendDataToProvider(value);
    });
   return listOfDocuments;  //fetching and returning list of All courses

  }

  Future <List <QueryDocumentSnapshot>> popularFetch(String user,BuildContext context)async{
    var value =   Provider.of<Data>(context,listen: false);
    await FirebaseFirestore.instance.collection(user).where("category",isEqualTo: "popular").get().then((querySnapshot){

      querySnapshot.docs.forEach((element) {
        getData(element);
      });
      sendDataToProvider(value);
    });
    return listOfDocuments;   //fetching and returning list of courses in Popular category
  }

  Future <List <QueryDocumentSnapshot>> topFetch(String user,BuildContext context)async{
    var value =   Provider.of<Data>(context,listen: false);
    await FirebaseFirestore.instance.collection(user).where("category",isEqualTo: "Top").get().then((querySnapshot){

      querySnapshot.docs.forEach((element) {
        getData(element);

      });
      sendDataToProvider(value);
    });
    return listOfDocuments;   //fetching and returning list of courses in Top category
  }

  Future <List <QueryDocumentSnapshot>> searchFetch(String user,String search,BuildContext context)async{

    await FirebaseFirestore.instance.collection(user).get().then((querySnapshot){
      var value =   Provider.of<Data>(context,listen: false);
      querySnapshot.docs.forEach((element) {
        if(element.data()["name"]!= null){
          listOfDocuments .add(element);
        }

      });

      listOfDocuments .removeWhere((element) {
       String data = (element.data()["name"]);

       if(!(data.toLowerCase().contains(search.toLowerCase())))
         {
           return true;
         }
       else{
         favList.add(element.data()["favourite"]);
         boolList.add(element.data()["coursevideo"]);
         courseNames.add(element.data()["name"]);
         courseImages.add(element.data()["image"]);

         return false;
       }
     });
      sendDataToProvider(value);
    });
    return listOfDocuments;   //fetching and returning list of courses that relates to string being searched for
  }

  void getData(QueryDocumentSnapshot element){
    listOfDocuments.add(element);
    favList.add(element.data()["favourite"]);
    boolList.add(element.data()["coursevideo"]);
    courseNames.add(element.data()["name"]);
    courseImages.add(element.data()["image"]);

    //fetching course data and assigning them to different lists - CourseNames,CourseImages,Favourites e.t.c
  }

  void sendDataToProvider(Data value){
    value.addFavouriteList(favList);
    value.addCourseBoolState(boolList);
    value.addCourseNames(courseNames);
    value.addCourseImages(courseImages);
    value.getResults(listOfDocuments );
    value.getCompletedCourses(listOfDocuments);
    value.getStartedCourseNames(listOfDocuments);

    //Sending all fetched data to the provider class

  }

}