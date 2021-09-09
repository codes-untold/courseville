
import 'package:courseville/Services/Constants.dart';
import 'package:flutter/material.dart';
import 'package:courseville/Widgets/OnBoardingWidgets.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../Services/CustomPainter.dart';
import 'LoginScreen.dart';


// ignore: must_be_immutable
class WelcomeScreen extends StatelessWidget {

  List <Widget> item = [HomeOne(),HomeTwo(),HomeThree()];
  int currentPos = 0;
  CarouselController buttonCarouselController = CarouselController();
  double screenHeight;
  double screenWidth;


  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: CustomPaint(
                size: Size(Constants.customPaintWidth,(Constants.customPaintWidth*2.5).toDouble()),
                painter: RPSCustomPainter(),
                child: Container(
                  width: screenWidth,
                  height:screenHeight,
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
                        height: screenHeight,
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

class HomeOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OnBoardingWidget(
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
    return OnBoardingWidget(
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
    return OnBoardingWidget(
      imageUrl: "images/welcomepic3.png",
      textOne: "Enjoy your Learning Journey📈",
      textTwo: "You are all set, begin your learning process with a positive attitude",
      imageSize: 300.0,
    );
  }
}


