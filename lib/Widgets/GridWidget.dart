import 'package:courseville/Networking/CourseFetch.dart';
import 'package:courseville/Widgets/CourseCards.dart';
import 'package:flutter/material.dart';

class GridWidget extends StatefulWidget {
String category;
String searchTerm;

GridWidget({this.category,this.searchTerm});

  @override
  _GridWidgetState createState() => _GridWidgetState();
}

class _GridWidgetState extends State<GridWidget> {
  List <Map<String,dynamic>> list = [];


  @override
  void initState(){

    fetch();
    super.initState();
  }

  fetch(){

    if(widget.searchTerm != null){
      print("working fine");
      CourseFetch().searchFetch(widget.searchTerm).then((value){
        setState(() {
          list = value;
        });
      });
    }

    else{
      print(widget.searchTerm);
      print(widget.category);
      switch(widget.category){
        case "all": CourseFetch().generalFetch().then((value){
          print("value");
          setState(() {
            list = value;
          });
        });
        break;
        case "popular": CourseFetch().popularFetch().then((value){
          print(value);
          setState(() {
            list = value;
          });
        });
        break;
        case "top": CourseFetch().topFetch().then((value){
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
    return list.isEmpty?
    CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 69, 22, 99))): GridView.count(crossAxisCount: 2,
    children: List.generate(list.length, (index){
      return CourseCard(querySnapshot: list[index],);
    }),);
  }
}
