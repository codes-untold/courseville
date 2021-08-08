import 'package:courseville/Screens/ForgotScreen.dart';
import 'package:courseville/Screens/RegistrationScreen.dart';
import 'package:courseville/TestWidget.dart';
import 'package:courseville/Widgets/HomeWidgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Screens/HomeScreen.dart';
import 'Screens/LoginScreen.dart';
import 'Screens/WelcomeScreen.dart';

Future <void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}

