import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CourselistTile extends StatelessWidget {


  Map<String,dynamic> list;
  int i;
  QueryDocumentSnapshot queryDocumentSnapshot;

  CourselistTile({this.list,this.i,this.queryDocumentSnapshot});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Card(
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
              placeholder: (context,url) => Icon(Icons.auto_stories,size: MediaQuery.of(context).size.width *0.1,
                color: Colors.black12,),
            ),
            title: Text(list["videoname"],
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500
            ),),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(list["videotime"],
              style: TextStyle(
                fontSize: 11
              ),),
            ),
            tileColor: Colors.white,
            trailing: Icon(Icons.play_circle_fill,
              color: Color.fromARGB(255, 69, 22, 99),),

          ),
        ),

      ),
    );
  }
}
