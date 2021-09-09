
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


import 'package:courseville/Networking/Authentication.dart';
import 'package:courseville/Screens/AllCertificateScreen.dart';
import 'package:courseville/Screens/PaymentScreen.dart';
import 'package:courseville/Services/Listener.dart';
import 'package:courseville/Services/Utils.dart';
import 'package:courseville/Widgets/ProfileCard.dart';
import 'package:courseville/Widgets/ProgreeCarousel.dart';
import 'package:courseville/Widgets/ProgressCard.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'AboutAppScreen.dart';
import 'LoginScreen.dart';

class ProfileScreen extends StatefulWidget {

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  bool hasStartedCourse;
  Data provider;
  int noOfCompletedCourses;
  String username;
  double screenHeight,screenWidth;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<Data>(context,listen: false);
    hasStartedCourse =  provider.updatedCourseProgress.isEmpty;
    noOfCompletedCourses = provider.completedCourses.length;
    username = provider.username;
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
             child: ModalProgressHUD(
               inAsyncCall: loading,
               child: SingleChildScrollView(
                 child: Padding(
                   padding: const EdgeInsets.only(left: 15 ,right: 15,top: 30),
                   child: Column(
                     children: [
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               ClipRRect(
                                 borderRadius: BorderRadius.all(Radius.circular(10)),
                                 child: Image.asset("images/avatar.jpg",width: 40,gaplessPlayback: true,),
                               ),
                              Icon(  Icons.sort,color: Colors.black87,),

                             ],
                           ),
                           SizedBox(height: screenHeight * 0.0398,),
                           Text("Hey $username!",style: TextStyle(
                             fontSize: 25,
                             fontWeight: FontWeight.w700
                           ),),
                           Text("This is your result overview",style: TextStyle(
                             fontSize: 14
                           ),),
                           SizedBox(height: screenHeight * 0.0265,),

                           hasStartedCourse?ProgressCard(hasStarted: hasStartedCourse,):ProgressCarousel(hasStarted: hasStartedCourse,)

                         ],
                       ),
                       SizedBox(height: screenHeight * 0.0332),

                     ProfileCard(text1: "images/aboutimage.png",text2: "About CourseVille",function: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context){
                         return AboutAppScreen();
                       }));
                     },),
                       SizedBox(height: screenHeight * 0.0132,),

                       ProfileCard(text1: "images/certificateimage.png",text2: "Certificates",function: (){
                         if(noOfCompletedCourses<1){
                           Utils().displayToast("You have no certificate Yet");
                           return;
                         }
                         Navigator.push(context, MaterialPageRoute(builder: (context){
                           return AllCertificateScreen();
                         }));
                       },),
                       SizedBox(height:screenHeight * 0.0132,),

                       ProfileCard(text1: "images/donationimage.png",text2: "Support Us",function: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context){
                           return PaymentScreen();
                         }));
                       },),

                       SizedBox(height:screenHeight * 0.0132,),

                       GestureDetector(
                         onTap: (){
                           setState(() {loading = true;});
                          Authentication().signOut().then((value){
                            setState(() {loading = false;
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                              return LoginScreen();
                            }));
                            });
                          });
                         },
                         child: Container(
                           width: double.infinity,
                           height: 50,
                           color: Color.fromARGB(255, 69, 22, 99),
                           child: Center(
                             child: Text("LOG OUT",
                               textAlign: TextAlign.center,
                               style: TextStyle(
                                   color: Colors.white
                               ),),
                           ),
                         ),
                       )],
                   ),
                 ),
               ),
             ),
            ),
    );
  }
}

