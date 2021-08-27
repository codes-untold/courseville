
import 'package:courseville/Services/Listener.dart';
import 'package:courseville/Widgets/ProfileCard.dart';
import 'package:courseville/Widgets/ProgreeCarousel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AboutAppScreen.dart';

class ProfileScreen extends StatelessWidget {



  bool hasStartedCourse;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Data>(context,listen: false);
   hasStartedCourse =  provider.updatedCourseResult.isNotEmpty;
    return Scaffold(
  //    backgroundColor: Colors.white,
      body: SafeArea(
             child: SingleChildScrollView(
               child: Padding(
                 padding: const EdgeInsets.only(left: 15,right: 15,top: 30),
                 child: Column(
                   children: [
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                            Icon(  Icons.sort,color: Colors.grey,),
                             ClipRRect(
                               borderRadius: BorderRadius.all(Radius.circular(10)),
                               child: Image.asset("images/avatar.jpg",width: 40,),
                             ),
                           ],
                         ),
                         SizedBox(height: 30,),
                         Text("Hey Xeroes!",style: TextStyle(
                           fontSize: 25,
                           fontWeight: FontWeight.w700
                         ),),
                         Text("This is your result overview",style: TextStyle(
                           fontSize: 14
                         ),),
                         SizedBox(height: 20,),
                         hasStartedCourse?ProgressCarousel():Text(""),

                       ],
                     ),
                     SizedBox(height: 25),
                   ProfileCard(text1: "images/aboutimage.png",text2: "About CourseVille",function: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context){
                       return AboutAppScreen();
                     }));
                   },),
                     SizedBox(height: 10,),
                     ProfileCard(text1: "images/certificateimage.png",text2: "Certificates"),
                     SizedBox(height: 10,),
                     ProfileCard(text1: "images/donationimage.png",text2: "Support Us"), ],
                 ),
               ),
             ),
            ),
    );
  }
}

