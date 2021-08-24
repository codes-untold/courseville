
import 'package:courseville/Screens/CourseVideoScreen.dart';
import 'package:courseville/Screens/LoginScreen.dart';
import 'package:courseville/Screens/NavigationScreen.dart';
import 'package:courseville/TestWidget.dart';
import 'package:courseville/Widgets/videoScreenListTile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/HomeScreen.dart';
import 'Screens/WelcomeScreen.dart';
import 'Services/Listener.dart';

Future <void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) async{

  });
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider<Data>(
    create:(context) => Data(),
    child: MaterialApp(
      routes: {
        "/hommy":(context) => HomeScreen(),
        "/fommy":(context) => CourseVideoScreen()
      },
     home: await getBoolToSF()? NavigationScreen(): WelcomeScreen(),
     // home:  WelcomeScreen(),
      //home: TestWidget(),


      debugShowCheckedModeBanner: false,
    ),
  ));
}

getBoolToSF()async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool boolvalue = preferences.getBool("boolvalue")?? false;
  return boolvalue;

}

