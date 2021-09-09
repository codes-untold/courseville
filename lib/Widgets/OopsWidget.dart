import 'package:flutter/material.dart';

class OopsWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          Text("Oops🙁",style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w900
          ),),
          Text("Couldn't find that course",
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),)
        ],
      ),
    );
  }
}
