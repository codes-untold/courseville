
import 'package:courseville/Widgets/CourseCards.dart';
import 'package:courseville/Widgets/GridWidget.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TestWidget extends StatelessWidget {
  @override

  YoutubePlayerController controller = YoutubePlayerController(initialVideoId: "sLbSguNcsrw",
  flags: YoutubePlayerFlags(autoPlay: true,mute: false));
  Widget build(BuildContext context) {

    return Scaffold(
      body:SafeArea(
       /* child: YoutubePlayer(
          controller: controller,
          liveUIColor: Colors.amber,
        ),*/
       child: Center(
         child: GridWidget(),
       ),
      ),
    );
  }
}


