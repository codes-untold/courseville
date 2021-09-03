import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {

  String text1;
  String text2;
  Function function;


  ProfileCard({this.text1,this.text2,this.function});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 9,
                child: Row(
                  children: [
                    CircleAvatar(
                        child: Image.asset(text1,width: 40,gaplessPlayback: true,),
                        radius:  30,
                        backgroundColor: Color.fromARGB(255, 233, 211, 248)
                    ),
                    SizedBox(width: 20,),
                    Text(text2,style: TextStyle(
                        fontSize: 13,
                    ),),
                  ],
                ),
              ),

              Expanded(
                  flex: 1,
                  child: IconButton(icon: Icon(Icons.arrow_forward_ios,size: 12,), onPressed: (){}))
            ],
          ),
        ),
      ),
    );
  }
}
