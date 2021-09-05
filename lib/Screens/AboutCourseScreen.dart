
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AboutCourseScreen extends StatelessWidget {

  QueryDocumentSnapshot queryDocumentSnapshot;
  var documentData;

  AboutCourseScreen({this.queryDocumentSnapshot});

  @override
  Widget build(BuildContext context) {
    documentData = queryDocumentSnapshot.data();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("About Course"),
        backgroundColor: Color.fromARGB(255, 69, 22, 99),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Text(documentData["name"],style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700
            ),),
            SizedBox(height: 10,),
            Text(documentData["description"],style:TextStyle(
              fontSize: 15,
              height: 1.35
            ),),
          ],
        ),
      ),
    );
  }
}
