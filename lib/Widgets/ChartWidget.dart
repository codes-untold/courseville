
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChartWidget extends StatelessWidget {

  double completedVideos;
  double totalVideos;

  ChartWidget({this.completedVideos,this.totalVideos});
  @override
  Widget build(BuildContext context) {
    double percentage = completedVideos/totalVideos * 100;
    int percent = percentage.round();
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 200,height: 200),
      child: Stack(
        children: [
          Center(child: Text("${percent.toString()}%",style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white
          ),)),
          PieChart(
              PieChartData(
                  sections: showingSections(),
                  sectionsSpace: 0,
                  centerSpaceRadius:35,
              )
          ),
        ],
      ),
    );
  }

  //returns a list showing sections of course that are completed
  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final radius = 10.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Color.fromARGB(255, 69, 22, 99),
            value: totalVideos - completedVideos ,
            showTitle: false,
            radius: radius,
          );
        case 1:
          return PieChartSectionData(
            color: Colors.white,
            value: completedVideos,
            radius: radius,
            showTitle: false,
          );

        default:
          throw Error();
      }
    });
  }
}




