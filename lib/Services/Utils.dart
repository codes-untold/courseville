
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Utils {

  static Future capture(GlobalKey key) async {
    if (key == null) return null;

    RenderRepaintBoundary boundary = key.currentContext.findRenderObject();
    final image = await boundary.toImage(pixelRatio: 3);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData.buffer.asUint8List();

    return pngBytes;
  }


  displayToast(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 69, 22, 99),
        fontSize: 12.0
    );

  }
  Future <List<String>> getBoolToSF()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List <String> value = preferences.getStringList("UID");
    return value;

  }


  addBoolToSF(_auth)async{
    List <String> list = [_auth.currentUser.uid,_auth.currentUser.displayName];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setStringList("UID", list);
    preferences.setBool("boolvalue", true);
  }



  showInSnackBar(String text,BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  void shareCourse({String imageUrl,String about,BuildContext context}) async {
    showInSnackBar("Sharing Course...", context);
    final response = await get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;
    final Directory temp = await getExternalStorageDirectory();
    final File imageFile = File('${temp.path}/tempImage.jpg');
    imageFile.writeAsBytesSync(bytes);
    Share.shareFiles(['${temp.path}/tempImage.jpg'], text: about,);
  }

}