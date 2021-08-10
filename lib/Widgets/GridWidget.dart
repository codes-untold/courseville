import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseville/Networking/CourseFetch.dart';
import 'package:courseville/Widgets/CourseCards.dart';
import 'package:flutter/material.dart';

class GridWidget extends StatefulWidget {
String category;
String searchTerm;
String user;

GridWidget({this.category,this.searchTerm,this.user});

  @override
  _GridWidgetState createState() => _GridWidgetState();
}

class _GridWidgetState extends State<GridWidget> {
  List <QueryDocumentSnapshot> list = [];


  @override
  void initState(){

    fetch();
    super.initState();
  }

  fetch(){

    if(widget.searchTerm != null){
      print("working fine");
      CourseFetch().searchFetch(widget.user,widget.searchTerm).then((value){
        setState(() {
          list = value;
        });
      });
    }

    else{
      switch(widget.category){
        case "all": CourseFetch().generalFetch(widget.user).then((value){
          print("value");
          setState(() {
            list = value;
          });
        });
        break;
        case "popular": CourseFetch().popularFetch(widget.user).then((value){
          print(value);
          setState(() {
            list = value;
          });
        });
        break;
        case "top": CourseFetch().topFetch(widget.user).then((value){
          print(value);
          setState(() {
            list = value;
          });
        });
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return list.isEmpty?widget.searchTerm != null?Text("oops"):
    CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 69, 22, 99))): GridView.count(crossAxisCount: 2,
    children: List.generate(list.length, (index){
      return CourseCard(querySnapshot: list[index],user: widget.user,);
    }),);
  }
}
