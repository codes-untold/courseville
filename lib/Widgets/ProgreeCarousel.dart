import 'package:carousel_slider/carousel_slider.dart';
import 'package:courseville/Services/Listener.dart';
import 'package:courseville/Widgets/ProgressCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProgressCarousel extends StatelessWidget {

  String name;
  int completedVideos;
  int totalVideos;
  List <Widget> list = [];
  bool hasStarted;

  ProgressCarousel({this.hasStarted});

  @override
  Widget build(BuildContext context) {
    generateResult(context);
    return CarouselSlider(
        items: list,
        options: CarouselOptions(
        height: 200,
        aspectRatio: 16/9,
        viewportFraction: 1.0,
        initialPage: 0,
        enableInfiniteScroll: false,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
    autoPlayAnimationDuration: Duration(milliseconds: 800),
    autoPlayCurve: Curves.fastOutSlowIn,
    enlargeCenterPage: true,
    scrollDirection: Axis.horizontal,
    onPageChanged: (index,reason){

    }

    ));
  }

  void generateResult(BuildContext context){
    var provider = Provider.of<Data>(context,listen: false);
    List items = provider.updatedCourseResult;
    print(provider.updatedCourseResult);
    double counter =0;

    for(int i = 0; i < items.length;i++){
      for(int a = 0; a < (items[i]["courseprogress"] as List).length;a++){
        if(items[i]["courseprogress"][a]){
          counter++;
        }
      }

      list.add(ProgressCard(name:items[i]["coursename"],completedVideos: counter,hasStarted: hasStarted,
        totalVideos: (items[i]["courseprogress"] as List).length.toDouble(),),
      );
      counter = 0;
    }
  }
}
