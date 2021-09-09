import 'package:flutter/material.dart';

class Painter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {



    Paint paint_0 = new Paint()
      ..color = Color(0xffa450f8)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;


    Path path_0 = Path();
    path_0.moveTo(0,0);
    path_0.quadraticBezierTo(size.width*0.1087500,0,size.width*0.1450000,0);
    path_0.quadraticBezierTo(size.width*0.2012500,size.height*0.0515000,size.width*0.1100000,size.height*0.0780000);
    path_0.lineTo(0,size.height*0.1160000);

    canvas.drawPath(path_0, paint_0);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}

class RPSCustomPainter2 extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {



    Paint paint_0 = new Paint()
      ..color = Color(0xffa450f8)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;


    Path path_0 = Path();
    path_0.moveTo(size.width,0);
    path_0.quadraticBezierTo(size.width*0.7425000,size.height*-0.0015000,size.width*0.6500000,0);
    path_0.quadraticBezierTo(size.width*0.5675000,size.height*0.0440000,size.width*0.6150000,size.height*0.0640000);
    path_0.quadraticBezierTo(size.width*0.7437500,size.height*0.0440000,size.width*0.7800000,size.height*0.0720000);
    path_0.cubicTo(size.width*0.8412500,size.height*0.1210000,size.width*0.5737500,size.height*0.1530000,size.width*0.7450000,size.height*0.1880000);
    path_0.cubicTo(size.width*0.8262500,size.height*0.2060000,size.width*0.8762500,size.height*0.1475000,size.width,size.height*0.1780000);
    path_0.quadraticBezierTo(size.width*1.0250000,size.height*0.1365000,size.width,0);
    path_0.close();

    canvas.drawPath(path_0, paint_0);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}

class RPSCustomPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {



    Paint paint_0 = new Paint()
      ..color = Color.fromARGB(255, 69, 22, 99)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;


    Path path_0 = Path();
    path_0.moveTo(0,size.height);
    path_0.quadraticBezierTo(0,size.height*0.7750000,0,size.height*0.7000000);
    path_0.quadraticBezierTo(size.width*-0.0025000,size.height*0.5505000,size.width*0.2500000,size.height*0.5500000);
    path_0.quadraticBezierTo(size.width*0.6250000,size.height*0.5500000,size.width*0.7500000,size.height*0.5500000);
    path_0.quadraticBezierTo(size.width*1.0025000,size.height*0.5510000,size.width,size.height*0.4500000);
    path_0.lineTo(size.width,size.height);
    path_0.lineTo(0,size.height);
    path_0.close();

    canvas.drawPath(path_0, paint_0);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
