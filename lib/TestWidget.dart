import 'package:flutter/material.dart';
import 'dart:ui' as ui;
class TestWidget extends StatelessWidget {

  double WIDTH =1000;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: CustomPaint(
                size: Size(WIDTH,(WIDTH*4).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                painter: RPSCustomPainter(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height:MediaQuery.of(context).size.height ,
                ),
              ),
            ),
         Center(child: GestureDetector(child: Text("hgjh"),
         onTap: (){print("cghch");},),) ],
        ),
      ),

    );
  }
}

class RPSCustomPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {



    Paint paint_0 = new Paint()
      ..color = Color.fromARGB(255, 254, 21, 25)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint_0.shader = ui.Gradient.linear(Offset(0,size.height*0.60),Offset(size.width*1.08,size.height*0.60),[Color(0xffcd1717),Color(0xffffffff)],[0.00,1.00]);

    Path path_0 = Path();
    path_0.moveTo(0,size.height*0.2000000);
    path_0.quadraticBezierTo(size.width*0.0520000,size.height*0.9690000,size.width*0.4800000,size.height*0.7800000);
    path_0.quadraticBezierTo(size.width*1.0840000,size.height*0.4610000,size.width*1.0400000,size.height);
    path_0.lineTo(0,size.height);

    canvas.drawPath(path_0, paint_0);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
