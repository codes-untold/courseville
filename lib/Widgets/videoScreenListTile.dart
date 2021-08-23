
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseville/Services/Listener.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VideoScreenListTile extends StatelessWidget {

  QueryDocumentSnapshot queryDocumentSnapshot;
  int i;
  VideoScreenListTile({this.queryDocumentSnapshot,this.i});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8,right: 8),
      child: Consumer<Data>(
        builder: (context,data,_){
          return ListTile(
            onTap: (){
              data.updateCurrentVideoID(i);

            },
            horizontalTitleGap: 1,
            selected: i == data.videoID ? true:false,
            selectedTileColor:  Color.fromARGB(255, 221, 212, 226),
            leading:   Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text((i+1).toString(),
                style: TextStyle(
                  fontSize: 13,
                ),),
            ),
            title:Text(queryDocumentSnapshot.data()["coursevideo"][i]["videoname"],
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14
              ),),
            subtitle:  Text("video ${queryDocumentSnapshot.data()["coursevideo"][i]["videotime"]}",
              style: TextStyle(
                  fontSize: 12
              ),) ,
          );
        },

      )
    );
  }
}


/* Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("1",
            style: TextStyle(
              fontSize: 15,
            ),),
          SizedBox(width: 30,),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("DART 2 - VERSION CHANGES",
                style: TextStyle(
                    fontWeight: FontWeight.w600
                ),),
              SizedBox(height: 3,),
              Text("video -04:58 mins",
              style: TextStyle(
                fontSize: 12
              ),),
            SizedBox(
              height: 15,
            )],)
        ],
      )*/