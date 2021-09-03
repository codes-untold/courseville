import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseville/Networking/Authentication.dart';
import 'package:courseville/Networking/CourseFetch.dart';
import 'package:courseville/Widgets/CourseCards.dart';
import 'package:courseville/Widgets/OopsWidget.dart';
import 'package:flutter/material.dart';

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
    someFunction(widget.user).then((value) {
      fetch();
    });

  }

  fetch(){

    if(widget.searchTerm != null){
      print("working fine");
      CourseFetch().searchFetch(widget.user,widget.searchTerm,context).then((value){

          setState(() {
            list = value;
          });

      });
    }

    else{
      switch(widget.category){
        case "all": CourseFetch().generalFetch(widget.user,widget.contextt).then((value){
          print("vfmdfjgjfhihtidurhdirht");
          if(mounted){
            setState(() {
              list = value;
            });
          }
        });
        break;
        case "popular": CourseFetch().popularFetch(widget.user,widget.contextt).then((value){
          print(value);
          if(mounted){
            setState(() {
              list = value;
            });
          }

        });
        break;
        case "top": CourseFetch().topFetch(widget.user,widget.contextt).then((value){
          print(value);
          if(mounted){
            setState(() {
              list = value;
            });
          }
        });
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return list.isEmpty?widget.searchTerm != null? OopsWidget():
    CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 69, 22, 99))): GridView.count(crossAxisCount: 2,
    children: List.generate(list.length, (index){
      return CourseCard(querySnapshot: list[index],user: widget.user,cardindex: index,totalCards: list.length,);
    }),);
  }


  Future <void> someFunction(String user)async{
     await Authentication().addUser(user);
  }
}
