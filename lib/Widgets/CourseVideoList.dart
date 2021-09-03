
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseville/Widgets/videoScreenListTile.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CourseVideoList extends StatelessWidget {

  QueryDocumentSnapshot queryDocumentSnapshot;
  String user;
  int courseIndex;
  YoutubePlayerController youtubePlayerController;

  CourseVideoList({this.queryDocumentSnapshot,this.user,this.courseIndex,this.youtubePlayerController});

  @override
  Widget build(BuildContext context) {
    return ListView.builder( itemBuilder: (context,index){
      return VideoScreenListTile(queryDocumentSnapshot: queryDocumentSnapshot,
        videoindex: index,user: user,courseindex: courseIndex,youtubePlayerController: youtubePlayerController,);
    },
    itemCount: (queryDocumentSnapshot.data()["coursevideo"] as List)?.length,
      shrinkWrap: true,
    );
  }
}
