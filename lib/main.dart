
import 'package:courseville/Screens/NavigationScreen.dart';
import 'package:courseville/Screens/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
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
        "/NavigationScreen":(context) => NavigationScreen(),
      },

   home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}
