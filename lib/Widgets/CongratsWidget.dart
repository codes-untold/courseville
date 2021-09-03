
import 'package:courseville/Widgets/CertificateScreen.dart';
import 'package:flutter/material.dart';

class CongratsWidget extends StatelessWidget {

  String username;
  String coursename;

  CongratsWidget({this.username,this.coursename});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.asset("images/certificateimage.png",gaplessPlayback: true,width: 150,),
                SizedBox(height: 10,),
                Text("Course Completed🎉",style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20
                ),),
                SizedBox(height: 10,),
                Text("Congratulations $username!!!, you have successfully completed the course "
                    "on $coursename ",style: TextStyle(
                    fontSize: 14
                ),),
                SizedBox(height: 130,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return CertificateScreen(username: username,coursename: coursename,);
                    }));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    color: Color(0xffa450f8),
                    child: Center(
                      child: Text("View Certificate",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white
                        ),),
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      )
    );
  }
}
