
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CourseVideoScreen extends StatelessWidget {

  final ktabs = <Tab>[Tab(child: Text("Lectures"),),Tab(child: Text("More"),),];
  List <Widget> kTabPages;

  YoutubePlayerController youtubePlayerController = YoutubePlayerController(initialVideoId: "qWVTxfLq2ak",
      flags: YoutubePlayerFlags(
        autoPlay: false,
      ) );

  @override
  Widget build(BuildContext context) {
    kTabPages = <Widget>[Text("cghjcg"),Text("dghctfn")];

    return DefaultTabController(
      length: ktabs.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(height: MediaQuery.of(context).size.height * 0.3125),
                child: YoutubePlayer(
                  controller: youtubePlayerController,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Color.fromARGB(255, 69, 22, 99),
                ),
              ),

            Padding(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text("Dart - Beginners Course",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600
                    ),),
                  SizedBox(height: 5,),
                  Text("Bryan Cairns",style: TextStyle(
                      color: Colors.grey[800]
                  ),),
                  SizedBox(height: 5,),

                  TabBar(
                    tabs:ktabs ,
                    labelColor: Colors.black,
                    indicatorColor: Colors.black,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelStyle: TextStyle(
                      //   fontSize: 16
                    ),),

                  SizedBox(height: 20,),


                ],
                ),
                padding: EdgeInsets.only(left: 15,right: 15,bottom: 15,top: 15)),
              Expanded(
                child: TabBarView(
                  children: kTabPages,
                ),
              )],
          )
        ),
      ),
    );
  }
}
