
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
}