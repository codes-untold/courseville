
import 'package:courseville/Screens/FavouriteScreen.dart';
import 'package:courseville/Screens/HomeScreen.dart';
import 'package:courseville/Screens/NotificationScreen.dart';
import 'package:courseville/Screens/ProfileScreen.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int selectedIndex = 0;

  List <Widget> widgets = [HomeScreen(),FavouriteScreen(),NotificationScreen(),ProfileScreen()];

  void onItemTapped(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: widgets[selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        items: const <BottomNavigationBarItem>
        [BottomNavigationBarItem(icon: Icon(Icons.home,size: 20.0,),label: "home",backgroundColor: Colors.white),
          BottomNavigationBarItem(icon: Icon(Icons.favorite,size: 20.0,),label: "favourite"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications,size: 20.0,),label: "notification"),
          BottomNavigationBarItem(icon: Icon(Icons.person_sharp,size: 20.0,),label: "profile")],
        currentIndex: selectedIndex,
        selectedItemColor: Color(0xffa450f8),
        unselectedItemColor: Color.fromARGB(255, 69, 22, 99),
        onTap: onItemTapped,
        selectedLabelStyle: TextStyle(color: Colors.white,fontSize: 1.0),
        unselectedLabelStyle:  TextStyle(color: Colors.white,fontSize: 1.0) ,
      ),
    );
  }
}
