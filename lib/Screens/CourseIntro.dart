
import 'package:courseville/Services/Constants.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseville/Screens/CourseVideoScreen.dart';
import 'package:flutter/rendering.dart';

import '../Services/CustomPainter.dart';


class CourseIntro extends StatelessWidget {

  QueryDocumentSnapshot queryDocumentSnapshot;
  String user;
  int courseIndex;
  CourseIntro({this.queryDocumentSnapshot,this.user,this.courseIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            child: CustomPaint(
              size: Size(Constants.customPaintWidth,(Constants.customPaintWidth*2.5).toDouble()),
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
                        tag: queryDocumentSnapshot.data()[Constants.COURSE_NAME],
                        child: CachedNetworkImage(
                          width: 200,
                          imageUrl: queryDocumentSnapshot.data()[Constants.COURSE_IMAGE],
                          placeholder: (context,url) => Icon(Icons.auto_stories,size: MediaQuery.of(context).size.width *0.3,
                            color: Colors.black12,),
                        ),
                      ),
                      Text(queryDocumentSnapshot.data()[Constants.COURSE_NAME],style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900
                      ),),
                      SizedBox(height: 10,),
                      Text(queryDocumentSnapshot.data()[Constants.COURSE_DESCRIPTION]
                        ,style: TextStyle(
                          height: 1.2
                        ),),  ],
                  ),
                ),
             GestureDetector(
               onTap: (){
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                   return CourseVideoScreen(queryDocumentSnapshot: queryDocumentSnapshot,user: user,i: courseIndex,);
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
