
import 'package:courseville/Services/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseville/Services/Listener.dart';
import 'package:courseville/Services/Utils.dart';
import 'package:courseville/Widgets/NotificationTile.dart';
import 'package:provider/provider.dart';



class NotificationScreen extends StatefulWidget {

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  Data provider;
  List<Map<String,dynamic>> list = [];
  List <Widget> listTile = [];
  String userID;


  @override
  void initState() {
    super.initState();
    provider = Provider.of<Data>(context,listen: false);
    list = provider.notifications;

    for(int i = 0;i < list.length; i++){
      listTile?.add(NotificationTile(notificationImage: list[i]["NotificationImage"],
        notificationMessage:list[i]["NotificationMessage"],));
      list[i].update("HasReadNotification", (value) =>true);
    }

    Utils().getBoolToSF().then((value) {
      userID = value[0];
     hasReadAllNotifications();
      });




  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 16,right: 16,top: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text("Your Activity〽️",style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700
                    ),),
                  ),
                SizedBox(height: 5,),
            Expanded(
              flex: 15,
              child: ListView(
                shrinkWrap: true,
                children: listTile,
              ),
            )
              ],
              ),
            ),
          ),
    );
  }


  //updates notification document on firebase to
  // show user has read all notifications
  void hasReadAllNotifications(){
   List notificationIds =  provider.notificationIDs;

   for(int i = 0; i< list.length; i++){
        FirebaseFirestore.instance.collection(userID).doc(Constants.NOTIFICATIONS).
        collection(Constants.NOTIFICATIONS).doc(notificationIds[i]).set(list[i]);
      }

  }
}

