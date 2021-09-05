import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseville/Screens/AboutCourseScreen.dart';
import 'package:courseville/Services.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class MorreWidget extends StatelessWidget {

  final queryDocumentSnapshot;
  final youtubePlayerController;

  MorreWidget({this.queryDocumentSnapshot,this.youtubePlayerController});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
             youtubePlayerController.pause();
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return AboutCourseScreen(queryDocumentSnapshot: queryDocumentSnapshot,);
              }));


            },
            child: Row(
              children: [
                Icon(Icons.info,color: Colors.grey,),
                SizedBox(width: 15,),
                Text("About this Course",style: TextStyle(
                    fontSize: 15
                ),)
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: (){
              Services().shareCourse(
                  about: aboutCourse(queryDocumentSnapshot.data()["name"]),
                  context: context,
                  imageUrl: queryDocumentSnapshot.data()["image"]
              );
            },
            child: Row(
              children: [
                Icon(Icons.share,color: Colors.grey,),
                SizedBox(width: 15,),
                Text("Share this Course",style: TextStyle(
                    fontSize: 15
                ),)
              ],
            ),
          ),
        ],
      ),
    );
  }

  String aboutCourse(String name){
    return "I am currently learning $name on the courseville app, its so much fun and exciting!!!"
        "Get it on Playstore Now!!!";
  }

}
