
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseville/Screens/HomeScreen.dart';
import 'package:courseville/Screens/LoginScreen.dart';
import 'package:courseville/Screens/NavigationScreen.dart';
import 'package:courseville/Screens/SplashScreen.dart';
import 'package:courseville/Services.dart';
import 'package:courseville/Services/Listener.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication{
  final _auth = FirebaseAuth.instance;
  Services services = Services();





Future <void> createUser(username,email,password)async{
  try {
    UserCredential newUser = await  _auth.createUserWithEmailAndPassword(email: email, password: password);
    if(newUser != null){
      await newUser.user.updateDisplayName(username).then((value)async{
        CollectionReference users = FirebaseFirestore.instance.collection(_auth.currentUser.uid);
        await users.doc(_auth.currentUser.uid).set({"id":_auth.currentUser.uid,})
            .then((value)async {
              await users.doc("Notifications").collection("Notifications").doc().set(
                  {"NotificationImage":null,
                  "NotificationMessage":"Hey $username, welcome to courseville😀",
                  "NotificationName": DateTime.now().millisecondsSinceEpoch.toString(),
                  "HasReadNotification": false}).then((value)async{

                await newUser.user.sendEmailVerification().then((value){
                  services.displayToast("Please check your email for verification");
                });
              });
        }).catchError((error){print(error);});
      });

    }
  } on Exception catch (e) {

    if(e.toString().contains("EMAIL_ALREADY_IN_USE")){
      services.displayToast("Email aleady exists");
    }

    if(e.toString().contains("NETWORK_REQUEST_FAILED")){
      services.displayToast("Network problem occured");
    }
  }
}



  bool checkEmail(String value){
    if(!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(value)){
      return false;
    }
    else{
      return true;
    }
      }


      Future <void> loginUser(String email,password,context)async{

        try {
          final newUser = await  _auth.signInWithEmailAndPassword(email: email, password: password);

          if(newUser != null) {
            if (newUser.user.emailVerified) {
              addBoolToSF(_auth);
              print(_auth.currentUser.uid);
              Provider.of<Data>(context,listen: false).updateUser(_auth.currentUser);
              checkForNotifications(_auth.currentUser.uid, context).then((value) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                  return NavigationScreen();
                }));
                services.displayToast("Email  verified");
              });

            }
            else {
              services.displayToast("Email not verified");
            }
          }
        } on Exception catch (e) {
          print(e.toString());
          if(e.toString().contains("network-request-failed")){
            services.displayToast("Network problem occured");
          }

          if(e.toString().contains("The password is invalid")){
            services.displayToast("Incorrect password");

          }
          if(e.toString().contains("no user record")){
            services.displayToast("User not found");
          }
        }
      }

      Future <void> resetEmail(email)async{
        try {
          await  _auth.sendPasswordResetEmail(email: email);
          services.displayToast(" Reset link has been sent to your email");
          print("working");


        } on Exception catch (e) {
          print(e.toString());
          if(e.toString().contains("no user record")){
            services.displayToast("User not found");
          }

          if(e.toString().contains("network-request-failed")){
            services.displayToast("Network problem occured");
          }

        }
      }


  Future <bool> addUser(String user) async {
    Map<String, dynamic> list;
    int a = 0;
    var res = await FirebaseFirestore.instance.doc("$user/${user}1").get();

    if (res.exists) {
      await FirebaseFirestore.instance.collection("Admin").get().then((
          QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((element) async {
          list = element.data();
          list.removeWhere((key, value) => key == "favourite");
          list.removeWhere((key, value) => key == "coursevideo");
          list.removeWhere((key, value) => key == "hasStartedCourse");
          list.removeWhere((key, value) => key == "hasEndedCourse");



          a++;

          await FirebaseFirestore.instance.collection(user).doc("$user$a")
              .update(list).then((value) {})
              .onError((error, stackTrace) {
            print(error);
          });
        });
      });
      return true;
    }

    else {
      await FirebaseFirestore.instance.collection("Admin").get().then((
          QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((element) async {
          a++;

          await FirebaseFirestore.instance.collection(user).doc("$user$a").set(
              element.data()).then((value) {})
              .onError((error, stackTrace) {
            print(error);
          });
        });
      });
      return true;
    }
  }

 Future <void> signOut()async{

    await _auth.signOut().then((value)async{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setBool("boolvalue", false);

    }).onError((error, stackTrace){
      Services().displayToast("An error occured");
    });
  }
}

Future <void> checkForNotifications(String user,BuildContext context)async{
  int noOfNotifications = 0;
  Data provider = Provider.of<Data>(context,listen: false);

  await FirebaseFirestore.instance.collection(user).doc("Notifications").
  collection("Notifications").orderBy("NotificationName").get().then((value){
    print("dghdthf");
    print(value.docs[0].data());

    for(int i = 0; i < value.docs.length; i++){
      provider.getNotifications(value.docs[i].data());
      provider.getNotificationIDs(value.docs[i].id);
      if(!value.docs[i].data()["HasReadNotification"]){
        provider.incrementNotificationCount();
      }
    }
    print(noOfNotifications);
    print(provider.notifications);

  });
}