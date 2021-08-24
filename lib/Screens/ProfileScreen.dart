
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                       Card(
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(15)
                         ),
                         color: Color.fromARGB(255, 69, 22, 99),
                         child: Container(
                           width: double.infinity,
                           height: 150,
                         ),
                       ),

                     ],
                   ),
                   SizedBox(height: 40,),
                 ProfileCard()],
               ),
             ),
            ),
    );
  }
}

class ProfileCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 9,
              child: Row(
                children: [
                  CircleAvatar(
                      child: Image.asset("images/aboutimage.png",width: 40,),
                      radius:  30,
                      backgroundColor: Color.fromARGB(255, 221, 179, 248)
                  ),
                  SizedBox(width: 20,),
                  Text("About CourseVille",style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500),),
                ],
              ),
            ),

            Expanded(
              flex: 1,
                child: IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: (){}))
          ],
        ),
      ),
    );
  }
}
