
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseville/Networking/CourseFetch.dart';
import 'package:courseville/Services/Utils.dart';
import 'package:courseville/Widgets/CourseCards.dart';
import 'package:courseville/Widgets/OopsWidget.dart';


// ignore: must_be_immutable
class GridWidget extends StatefulWidget {

String category;
String searchTerm;
String user;
BuildContext contextt;

GridWidget({this.category,this.searchTerm,this.user,this.contextt});

  @override
  _GridWidgetState createState() => _GridWidgetState();
}

class _GridWidgetState extends State<GridWidget> {
  List <QueryDocumentSnapshot> list = [];
  bool hasLoaded;



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  @override
  void initState(){
    super.initState();
    getUserData(widget.user).then((value) {
      fetch();
    }).onError((error, stackTrace) => Utils().displayToast("An error occured"));

  }

  fetch(){

    if(widget.searchTerm != null){
      CourseFetch().searchFetch(widget.user,widget.searchTerm,context).then((value){
          setState(() {
            list = value;
          });
      }).onError((error, stackTrace) =>  Utils().displayToast("An error occured"));
    }

    else{
      switch(widget.category){
        case "all": CourseFetch().generalFetch(widget.user,widget.contextt).then((value){
          if(mounted){
            setState(() {
              list = value;
            });
          }
        }).onError((error, stackTrace) =>  Utils().displayToast("An error occured"));
        break;

        case "popular": CourseFetch().popularFetch(widget.user,widget.contextt).then((value){
          if(mounted){
            setState(() {
              list = value;
            });
          }
        }).onError((error, stackTrace) =>  Utils().displayToast("An error occured"));
        break;

        case "top": CourseFetch().topFetch(widget.user,widget.contextt).then((value){
          if(mounted){
            setState(() {
              list = value;
            });
          }
        }).onError((error, stackTrace) =>  Utils().displayToast("An error occured"));
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return list.isEmpty?widget.searchTerm != null? OopsWidget():
    CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 69, 22, 99))): GridView.count(crossAxisCount: 2,
    children: List.generate(list.length, (index){
      return CourseCard(querySnapshot: list[index],user: widget.user,cardIndex: index,totalCards: list.length,);
    }),);
  }


  //gets user data from firebase
  Future <void> getUserData(String user)async{
     await CourseFetch().getUserData(user);
  }
}
