
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseville/Widgets/videoScreenListTile.dart';
import 'package:flutter/material.dart';

class CourseVideoList extends StatelessWidget {

  QueryDocumentSnapshot queryDocumentSnapshot;

  CourseVideoList({this.queryDocumentSnapshot});

  @override
  Widget build(BuildContext context) {
    return ListView.builder( itemBuilder: (context,index){
      return VideoScreenListTile(queryDocumentSnapshot: queryDocumentSnapshot,i: index,);
    },
    itemCount: (queryDocumentSnapshot.data()["coursevideo"] as List)?.length,
      shrinkWrap: true,
    );
  }
}
