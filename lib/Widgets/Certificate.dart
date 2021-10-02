import 'package:flutter/material.dart';

class Certificate extends StatelessWidget {
  const Certificate({
    Key key,
    @required this.username,
    @required this.coursename,
  }) : super(key: key);

  final String username;
  final String coursename;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset("images/certify.jpg",gaplessPlayback: true,),
        Positioned(child: Text(username,style: TextStyle(
            fontSize: 18
        ),),
          top: MediaQuery.of(context).size.width * 0.36,),

        Positioned(child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: 200),
            child: Text("Upon his/her successful completion of the course: Introduction to $coursename ",
              style: TextStyle(
                  fontSize: 11
              ),
              textAlign: TextAlign.center,)),
          top: MediaQuery.of(context).size.width * 0.47,)
      ],);
  }
}