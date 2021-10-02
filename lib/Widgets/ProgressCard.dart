
import 'package:flutter/material.dart';
import 'ChartWidget.dart';

// ignore: must_be_immutable
class ProgressCard extends StatelessWidget {


  String name;
  double completedVideos;
  double totalVideos;
  bool hasStarted;


  ProgressCard({this.name,this.completedVideos,this.totalVideos,this.hasStarted});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      color: Color.fromARGB(255, 69, 22, 99),
      child: Container(
        width: double.infinity,
        height: 200,
        child: hasStarted? Center(child:
        Text("You have no Courses yet",style: TextStyle(
          color: Colors.white,
          fontSize: 15
        ),)): Row(
          children: [
            Expanded(child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name!=null?name:"",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white
                      ),),
                    SizedBox(height: 10,),
                    Text("${completedVideos.round()} of ${totalVideos.round()} videos completed",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white
                      ),)
                  ],
                ),
              ),
            )),
            Expanded(child: ChartWidget(completedVideos: completedVideos,totalVideos: totalVideos,)),
          ],
        ),
      ),
    );
  }


}

