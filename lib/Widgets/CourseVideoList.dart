
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseville/Widgets/videoScreenListTile.dart';
import 'package:flutter/material.dart';

class CourseVideoList extends StatelessWidget {

  QueryDocumentSnapshot queryDocumentSnapshot;
  String user;
  int courseIndex;

  CourseVideoList({this.queryDocumentSnapshot,this.user,this.courseIndex});

  @override
  Widget build(BuildContext context) {
    return ListView.builder( itemBuilder: (context,index){
      return VideoScreenListTile(queryDocumentSnapshot: queryDocumentSnapshot,videoindex: index,user: user,courseindex: courseIndex,);
    },
    itemCount: (queryDocumentSnapshot.data()["coursevideo"] as List)?.length,
      shrinkWrap: true,
    );
  }
}
