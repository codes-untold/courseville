
import 'package:flutter/material.dart';

class AppreciationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Image.asset("images/avatar2.png",gaplessPlayback: true,width: 150,),
          SizedBox(height: 10,),
          Text("Transaction Successful👍",style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20
          ),),
          SizedBox(height: 10,),
          Text("Thanks for your great support to the courseville Team",style: TextStyle(
              fontSize: 14
          ),),
          SizedBox(height: 50,),

        ],
      ),
    );
  }
}
