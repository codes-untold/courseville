
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Services{

   displayToast(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 12.0
    );

  }
   Future <List<String>> getBoolToSF()async{
     SharedPreferences preferences = await SharedPreferences.getInstance();
     List <String> boolvalue = preferences.getStringList("UID");
     return boolvalue;

   }

   showInSnackBar(String text,BuildContext context){
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
   }

   void shareCourse({String imageUrl,String about,BuildContext context}) async {
     showInSnackBar("Sharing Course...", context);
     final response = await get(Uri.parse(imageUrl));
     final bytes = response.bodyBytes;
     final Directory temp = await getTemporaryDirectory();
     final File imageFile = File('${temp.path}/tempImage.jpg');
     imageFile.writeAsBytesSync(bytes);
     Share.shareFiles(['${temp.path}/tempImage.jpg'], text: about,);
   }


}
