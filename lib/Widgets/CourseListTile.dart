import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CourselistTile extends StatelessWidget {

  QueryDocumentSnapshot queryDocumentSnapshot;
  int i;

  CourselistTile({this.queryDocumentSnapshot,this.i});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      elevation: 5,
      child: ClipPath(
        clipper: ShapeBorderClipper(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            )
        ),
        child: ListTile(
      //    contentPadding: EdgeInsets.only(bottom: 3),
          leading:  CachedNetworkImage(
            imageUrl: queryDocumentSnapshot.data()["image"],
            placeholder: (context,url) => Icon(Icons.auto_stories,size: MediaQuery.of(context).size.width *0.3,
              color: Colors.black12,),
          ),
          title: Text(queryDocumentSnapshot.data()["coursevideo"][i]["videoname"],
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700
          ),),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(queryDocumentSnapshot.data()["coursevideo"][i]["videotime"],
            style: TextStyle(
              fontSize: 11
            ),),
          ),
          tileColor: Colors.white,
          trailing: Icon(Icons.play_circle_fill,
            color: Color.fromARGB(255, 69, 22, 99),),

        ),
      ),

    );
  }
}
