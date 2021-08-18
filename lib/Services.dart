
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
}
