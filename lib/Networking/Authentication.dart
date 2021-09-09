
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseville/Screens/NavigationScreen.dart';
import 'package:courseville/Services/Listener.dart';
import 'package:courseville/Services/Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication{

  final _auth = FirebaseAuth.instance;

    //create user account on firebase
    Future <void> createUser(username,email,password)async{
      try {
        UserCredential newUser = await  _auth.createUserWithEmailAndPassword(email: email, password: password);
        if(newUser != null){
          await newUser.user.updateDisplayName(username).then((value)async{
            CollectionReference users = FirebaseFirestore.instance.collection(_auth.currentUser.uid);
            await users.doc(_auth.currentUser.uid).set({"id":_auth.currentUser.uid,})
                .then((value)async {
                  await createNotificationForUser(users, username).then((value)async{
                    await newUser.user.sendEmailVerification().then((value){
                      Utils().displayToast("Please check your email for verification");
                    });
                  });
            }).catchError((error){print(error);});
          });

        }
      } on Exception catch (e) {

        if(e.toString().contains("EMAIL_ALREADY_IN_USE")){
          Utils().displayToast("Email aleady exists");
        }

        if(e.toString().contains("NETWORK_REQUEST_FAILED")){
          Utils().displayToast("Network problem occured");
        }
      }
    }


    //check for wrong email formatting
  bool checkEmail(String value){
    if(!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(value)){
      return false;
    }
    else{
      return true;
    }
      }


      //login user into app
      Future <void> loginUser(String email,password,context)async{

        try {
          final newUser = await  _auth.signInWithEmailAndPassword(email: email, password: password);
          if(newUser != null) {
            if (newUser.user.emailVerified) {
              Utils().addBoolToSF(_auth);
              Provider.of<Data>(context,listen: false).updateUser(_auth.currentUser);
              checkForNotifications(_auth.currentUser.uid, context).then((value) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                  return NavigationScreen();
                }));
              });
            }
            else {
              Utils().displayToast("Email not verified");
            }
          }
        } on Exception catch (e) {
          print(e.toString());
          if(e.toString().contains("network-request-failed")){
            Utils().displayToast("Network problem occured");
          }

          if(e.toString().contains("The password is invalid")){
            Utils().displayToast("Incorrect password");

          }
          if(e.toString().contains("no user record")){
            Utils().displayToast("User not found");
          }
        }
      }

        //sends email to reset password
      Future <void> resetEmail(email)async{
        try {
          await  _auth.sendPasswordResetEmail(email: email);
          Utils().displayToast(" Reset link has been sent to your email");
          print("working");


        } on Exception catch (e) {
          print(e.toString());
          if(e.toString().contains("no user record")){
            Utils().displayToast("User not found");
          }

          if(e.toString().contains("network-request-failed")){
            Utils().displayToast("Network problem occured");
          }

        }
      }

  //fetches existing user data from firebase fireStore or creates if not existing
   Future <bool> getUserData(String user) async {
    Map<String, dynamic> map;
    int count= 0;
    var res = await FirebaseFirestore.instance.doc("$user/${user}1").get();

    if (res.exists) {
      //if user document already exists, fetch documents from general list of courses
      //to add new courses to exisiting user's collection
      await FirebaseFirestore.instance.collection("Admin").get().then((
          QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((element) async {
          map = element.data();
          //Remove user specific fields to avoid overiding fields in user documents
          map.removeWhere((key, value) => key == "favourite");
          map.removeWhere((key, value) => key == "coursevideo");
          map.removeWhere((key, value) => key == "hasStartedCourse");
          map.removeWhere((key, value) => key == "hasEndedCourse");



          count++;
          await FirebaseFirestore.instance.collection(user).doc("$user$count")
              .update(map).then((value) {})
              .onError((error, stackTrace) {
            print(error);
          });
        });
      });
      return true;
    }

    else {
      //if user document does not exist,fetch all item from general course list
      // and update user collection
      await FirebaseFirestore.instance.collection("Admin").get().then((
          QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((element) async {
          count++;

          await FirebaseFirestore.instance.collection(user).doc("$user$count").set(
              element.data()).then((value) {})
              .onError((error, stackTrace) {
            print(error);
          });
        });
      });
      return true;
    }
  }

    //signs out user out of user account
 Future <void> signOut()async{

    await _auth.signOut().then((value)async{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setBool("boolvalue", false);

    }).onError((error, stackTrace){
      Utils().displayToast("An error occured");
    });
  }

      //Create welcome notification for user when user signs up
  Future <void> createNotificationForUser(CollectionReference users,String username )async{
    await users.doc("Notifications").collection("Notifications").doc().set(
        {"NotificationImage":null,
          "NotificationMessage":"Hey $username, welcome to courseville😀",
          "NotificationName": DateTime.now().millisecondsSinceEpoch.toString(),
          "HasReadNotification": false});
       }
  }

      //Check for available notifications when user logs into account
Future <void> checkForNotifications(String user,BuildContext context)async{
  int noOfNotifications = 0;
  Data provider = Provider.of<Data>(context,listen: false);

  await FirebaseFirestore.instance.collection(user).doc("Notifications").
  collection("Notifications").orderBy("NotificationName").get().then((value){
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
