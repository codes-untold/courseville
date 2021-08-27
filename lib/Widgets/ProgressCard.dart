
import 'package:courseville/Services/Listener.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ChartWidget.dart';
class ProgressCard extends StatelessWidget {


  String name;
  double completedVideos;
  double totalVideos;


  ProgressCard({this.name,this.completedVideos,this.totalVideos});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      color: Color.fromARGB(255, 69, 22, 99),
      child: Container(
        width: double.infinity,
        height: 150,
        child: Row(
          children: [
            Expanded(child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(name,
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

