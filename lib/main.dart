
import 'package:courseville/Screens/AllCertificateScreen.dart';
import 'package:courseville/Screens/NavigationScreen.dart';
import 'package:courseville/Screens/ProfileScreen.dart';
import 'package:courseville/Screens/SplashScreen.dart';
import 'package:courseville/TestWidget.dart';
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
        "/hommy":(context) => NavigationScreen(),
      },
    // home: await getBoolToSF()? NavigationScreen(): WelcomeScreen(),
   home: SplashScreen(),
    //  home: AllCertificateScreen(),


      debugShowCheckedModeBanner: false,
    ),
  ));
}
