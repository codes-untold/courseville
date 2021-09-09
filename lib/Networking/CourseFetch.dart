import 'package:courseville/Services/Constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseville/Services/Listener.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CourseFetch{


  List <Map<String,dynamic>> searchList = [];
  List <QueryDocumentSnapshot> listOfDocuments  = [];
  List <bool> favList = [];
  List courseVideoList = [];
  List courseNames = [];
  List courseImages = [];


  //fetches all course documents from user's collection on Cloud FireStore
  // and returns a list of querysnapshotdocuments
  Future <List <QueryDocumentSnapshot>> generalFetch(String user,BuildContext context)async{
      var value =   Provider.of<Data>(context,listen: false);
    await FirebaseFirestore.instance.collection(user).get().then((querySnapshot){
      courseVideoList.clear();

     querySnapshot.docs.forEach((element) {
       if(element.data()[Constants.COURSE_NAME]!= null){
         getData(element);
       }

     });
     sendDataToProvider(value);
    });
   return listOfDocuments;  //fetching and returning list of All courses

  }


  //fetches course documents from user collection on Cloud FireStore
  // where category is = popular and returns a list
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


  //fetches course documents from user collection on Cloud FireStore
  // where category is = Top and returns a list
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
        if(element.data()[Constants.COURSE_NAME]!= null){
          listOfDocuments .add(element);
        }

      });

      listOfDocuments .removeWhere((element) {
       String data = (element.data()[Constants.COURSE_NAME]);

       if(!(data.toLowerCase().contains(search.toLowerCase())))
         {
           return true;
         }
       else{
         favList.add(element.data()[Constants.COURSE_FAVOURITE]);
         courseVideoList.add(element.data()[Constants.COURSE_VIDEO_DATA]);
         courseNames.add(element.data()[Constants.COURSE_NAME]);
         courseImages.add(element.data()[Constants.COURSE_IMAGE]);

         return false;
       }
     });
      sendDataToProvider(value);
    });
    return listOfDocuments;   //fetching and returning list of courses that relates to string being searched for
  }
//fetching course data and assigning them to different lists - CourseNames,CourseImages,Favourites e.t.c
  void getData(QueryDocumentSnapshot element){
    listOfDocuments.add(element);
    favList.add(element.data()[Constants.COURSE_FAVOURITE]);
    courseVideoList.add(element.data()[Constants.COURSE_VIDEO_DATA]);
    courseNames.add(element.data()[Constants.COURSE_NAME]);
    courseImages.add(element.data()[Constants.COURSE_IMAGE]);


  }

  //Sending all fetched data to the provider class
  void sendDataToProvider(Data value){
    value.addFavouriteList(favList);
    value.getCourseVideoList(courseVideoList);
    value.getResults(listOfDocuments );
    value.getCompletedCourses(listOfDocuments);
    value.getStartedCourseNames(listOfDocuments);



  }

  //fetches existing user data from firebase fireStore or creates if not existing
  Future <bool> getUserData(String user) async {
    Map<String, dynamic> map;
    int count= 0;
    var userDocument = await FirebaseFirestore.instance.doc("$user/${user}1").get();

    if (userDocument.exists) {
      //if user document already exists, fetch documents from general list of courses
      //to add new courses to exisiting user's collection
      await FirebaseFirestore.instance.collection("Admin").get().then((
          QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((element) async {
          map = element.data();
          //Remove user specific fields to avoid overiding fields in user documents
          map.removeWhere((key, value) => key == Constants.COURSE_FAVOURITE);
          map.removeWhere((key, value) => key == Constants.COURSE_VIDEO_DATA);
          map.removeWhere((key, value) => key == Constants.COURSE_HAS_STARTED_COURSE);
          map.removeWhere((key, value) => key == Constants.COURSE_HAS_ENDED_COURSE);



          count++;
          await FirebaseFirestore.instance.collection(user).doc("$user$count")
              .update(map).then((value) {})
              .onError((error, stackTrace) {
            print(error);
          });
        });
      });
      return true;
    }

    else {
      //if user document does not exist,fetch all item from general course list
      // and update user collection
      await FirebaseFirestore.instance.collection("Admin").get().then((
          QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((element) async {
          count++;

          await FirebaseFirestore.instance.collection(user).doc("$user$count").set(
              element.data()).then((value) {})
              .onError((error, stackTrace) {
            print(error);
          });
        });
      });
      return true;
    }
  }
}