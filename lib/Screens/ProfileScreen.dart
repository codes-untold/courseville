
import 'package:courseville/Screens/AllCertificateScreen.dart';
import 'package:courseville/Screens/PaymentScreen.dart';
import 'package:courseville/Services.dart';
import 'package:courseville/Services/Listener.dart';
import 'package:courseville/Widgets/ProfileCard.dart';
import 'package:courseville/Widgets/ProgreeCarousel.dart';
import 'package:courseville/Widgets/ProgressCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave/core/flutterwave.dart';
import 'package:provider/provider.dart';

import 'AboutAppScreen.dart';

class ProfileScreen extends StatelessWidget {

  bool hasStartedCourse;
  Data provider;
  int noOfCompletedCourses;
  String username;

  @override
  Widget build(BuildContext context) {
   provider = Provider.of<Data>(context,listen: false);
   hasStartedCourse =  provider.updatedCourseResult.isEmpty;
   noOfCompletedCourses = provider.completedCourses.length;
   username = provider.username;
   print(hasStartedCourse);
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
                               child: Image.asset("images/avatar.jpg",width: 40,gaplessPlayback: true,),
                             ),
                           ],
                         ),
                         SizedBox(height: 30,),
                         Text("Hey $username!",style: TextStyle(
                           fontSize: 25,
                           fontWeight: FontWeight.w700
                         ),),
                         Text("This is your result overview",style: TextStyle(
                           fontSize: 14
                         ),),
                         SizedBox(height: 20,),
                         hasStartedCourse?ProgressCard(hasStarted: hasStartedCourse,):ProgressCarousel(hasStarted: hasStartedCourse,)

                       ],
                     ),
                     SizedBox(height: 25),

                   ProfileCard(text1: "images/aboutimage.png",text2: "About CourseVille",function: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context){
                       return AboutAppScreen();
                     }));
                   },),
                     SizedBox(height: 10,),

                     ProfileCard(text1: "images/certificateimage.png",text2: "Certificates",function: (){
                       if(noOfCompletedCourses<1){
                         Services().displayToast("You have no certificate Yet");
                         return;
                       }
                       Navigator.push(context, MaterialPageRoute(builder: (context){
                         return AllCertificateScreen();
                       }));
                     },),
                     SizedBox(height: 10,),

                     ProfileCard(text1: "images/donationimage.png",text2: "Support Us",function: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context){
                         return PaymentScreen();
                       }));
                     },), ],
                 ),
               ),
             ),
            ),
    );
  }

  void launchPayment()async{

    /* Flutterwave flutterwave = Flutterwave.forUIPayment
       ();*/
  }
}

