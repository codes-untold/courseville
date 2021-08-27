import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseville/Screens/CourseScreen.dart';
import 'package:courseville/Screens/CourseVideoScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../CustomPainter.dart';
import 'LoginScreen.dart';

class CourseIntro extends StatelessWidget {

  double WIDTH = 200;
  QueryDocumentSnapshot queryDocumentSnapshot;
  String user;
  int courseindex;
  CourseIntro({this.queryDocumentSnapshot,this.user,this.courseindex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            child: CustomPaint(
              size: Size(WIDTH,(WIDTH*2.5).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
              painter: RPSCustomPainter2(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.height ,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(child: Container(),
                flex: 4,),
                Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      Hero(
                        tag: queryDocumentSnapshot.data()['name'],
                        child: CachedNetworkImage(
                          width: 200,
                          imageUrl: queryDocumentSnapshot.data()['image'],
                          placeholder: (context,url) => Icon(Icons.auto_stories,size: MediaQuery.of(context).size.width *0.3,
                            color: Colors.black12,),
                        ),
                      ),
                      Text(queryDocumentSnapshot.data()['name'],style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900
                      ),),
                      SizedBox(height: 10,),
                      Text(queryDocumentSnapshot.data()["description"]
                        ,style: TextStyle(
                          height: 1.2
                        ),),  ],
                  ),
                ),
             GestureDetector(
               onTap: (){
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                   return CourseVideoScreen(queryDocumentSnapshot: queryDocumentSnapshot,user: user,i: courseindex,);
                 }));
               },
               child: Container(
                 width: double.infinity,
                 height: 50,
                 color: Color(0xffa450f8),
                 child: Center(
                   child: Text("Start Course",
                   textAlign: TextAlign.center,
                   style: TextStyle(
                     color: Colors.white
                   ),),
                 ),
               ),
             ),

      ],
            ),
          ), ],

      ),
    );
  }
}
