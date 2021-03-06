
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseville/Screens/NavigationScreen.dart';
import 'package:courseville/Services/Listener.dart';
import 'package:courseville/Services/Utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'OnBoardingScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Widget screen;
  Image logo;
  String user;
  bool loading = false;
  Data provider;
  List<Map<String,dynamic>> notifications = [];



  @override
  void initState() {
    super.initState();
    provider = Provider.of<Data>(context,listen: false);
    logo = Image.asset("images/applogo.png",gaplessPlayback: true,);
    Future.delayed(Duration(seconds: 1),(){
      setState(() {loading = true;});
      checkForUser();
    });

  }

  @override
  void didChangeDependencies() {
    precacheImage(logo.image, context);
    super.didChangeDependencies();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Image(image: logo.image,gaplessPlayback: true,width: 250,),
                ),
              ),
              Visibility(
                  visible: loading,
                  child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 69, 22, 99)))),
              SizedBox(height: 10,)
            ],
          ),
        ),
      ),
    );
  }

  Future <bool> getBoolToSF()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool boolvalue = preferences.getBool("boolvalue")?? false;
    return boolvalue;

  }


  void checkForUser(){
    Utils().isUserLoggedIn().then((value)async{
      if(value){
        Utils().getBoolToSF().then((value)async {
          user = value[0];
          await checkForNotifications(user).then((value){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
              return NavigationScreen();
            }));
          }).onError((error, stackTrace) =>Utils().displayToast("Please check Internet connection"));
        });
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return WelcomeScreen();
        }));
      }
    });

  }


  //Checks for unread notifications
  Future <void> checkForNotifications(String user)async{

    await FirebaseFirestore.instance.collection(user).doc("Notifications").
    collection("Notifications").orderBy("NotificationName",descending: false).get().then((value){

      print(value.docs[0].data());

      for(int i = 0; i < value.docs.length; i++){
        provider.getNotifications(value.docs[i].data());
        provider.getNotificationIDs(value.docs[i].id);

        if(!value.docs[i].data()["HasReadNotification"]){
          provider.incrementNotificationCount();
        }else{
          provider.resetNotificationCount();
        }
      }
    });
  }
}

