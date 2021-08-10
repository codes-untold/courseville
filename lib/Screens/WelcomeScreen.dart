import 'package:courseville/Widgets/HomeWidgets.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:ui' as ui;

import 'LoginScreen.dart';


class WelcomeScreen extends StatelessWidget {

  List <Widget> item = [HomeOne(),HomeTwo(),HomeThree()];
  int currentPos = 0;
  CarouselController buttonCarouselController = CarouselController();
  double value;

  double WIDTH =1000;
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    print(MediaQuery.of(context).size.width);
    value = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: CustomPaint(
                size: Size(WIDTH,(WIDTH*2.5).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                painter: RPSCustomPainter(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height:MediaQuery.of(context).size.height ,
                ),
              ),
            ),
            Column(
              children: [
                Expanded(
                  flex: 14,
                  child: CarouselSlider(
                    carouselController: buttonCarouselController,
                    items: item,
                    options: CarouselOptions(
                        height: value,
                        aspectRatio: 16/9,
                        viewportFraction: 0.9,
                        initialPage: 0,
                        enableInfiniteScroll: false,
                        reverse: false,
                        autoPlay: false,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index,reason){
                          currentPos = index;
                          print(currentPos);


                        }

                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: ElevatedButton(
                    onPressed: (){
                      if(currentPos == 2){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                          return LoginScreen();
                        }));
                      }
                      else{
                        buttonCarouselController.nextPage(
                            duration: Duration(milliseconds: 300), curve: Curves.linear);
                      }

                    },
                    child: Icon(Icons.arrow_forward_ios,color: Color.fromARGB(255, 165, 33, 243)),
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        primary: Colors.white,
                        padding: EdgeInsets.all(20)
                    ),
                  ),
                )
              ],
            ) ],
        ),
      ),

    );
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

//Color.fromARGB(255, 69, 22, 99)
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}


class HomeOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomeWidget(
      imageUrl: "images/welcomepic1.png",
      textOne: "Get Courses for Free💡",
      textTwo: "Get organised list of videos from learning sites "
          "best suited to your learning curve",
      imageSize: 500.0,
    );
  }
}

class HomeTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomeWidget(
      imageUrl: "images/welcomepic2.png",
      textOne: "Course Articles📑",
      textTwo: "Get tons of course resources which will aid you "
          "in your learning journey",
      imageSize: 500.0,
    );
  }
}

class HomeThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomeWidget(
      imageUrl: "images/welcomepic3.png",
      textOne: "Enjoy your Learning Journey📈",
      textTwo: "You are all set, begin your learning process with a positive attitude",
      imageSize: 300.0,
    );
  }
}


