import 'package:flutter/material.dart';

class OnBoardingWidget extends StatelessWidget {

  final imageUrl;
  final textOne;
  final textTwo;
  final imageSize;
  OnBoardingWidget({this.imageUrl,this.textOne,this.textTwo,this.imageSize});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            flex: 14,
            child: Image.asset(imageUrl,
            width: imageSize,)),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(textOne,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700
                  ),),
                SizedBox(
                  height: 8,
                ),
                Text(textTwo,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400
                    )),


              ],
            ),
          ),
        )
      ],
    );
  }
}
