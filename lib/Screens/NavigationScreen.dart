
import 'package:courseville/Screens/FavouriteScreen.dart';
import 'package:courseville/Screens/HomeScreen.dart';
import 'package:courseville/Screens/NotificationScreen.dart';
import 'package:courseville/Screens/ProfileScreen.dart';
import 'package:courseville/Services/Listener.dart';
import 'package:flutter/material.dart';
import 'package:icon_badge/icon_badge.dart';
import 'package:provider/provider.dart';

class NavigationScreen extends StatefulWidget {

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int selectedIndex = 0;
  Data provider;

  List <Widget> widgets = [HomeScreen(),FavouriteScreen(),NotificationScreen(),ProfileScreen()];


  @override
  void initState() {
    super.initState();
    provider = Provider.of<Data>(context,listen: false);
  }
  void onItemTapped(int index){
    if(index == 2){
      provider.resetNotificationCount();
    }
    setState(() {selectedIndex = index;});
  }

  Widget icon(int count){
    return  IconBadge(icon: Icon(Icons.notifications),
      itemCount: count,
      hideZero: true,);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: widgets[selectedIndex]),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        items: <BottomNavigationBarItem>
        [BottomNavigationBarItem(icon: Icon(Icons.home,size: 20.0,),label: "home",backgroundColor: Colors.white),
          BottomNavigationBarItem(icon: Icon(Icons.favorite,size: 20.0,),label: "favourite"),
          BottomNavigationBarItem(icon: Consumer<Data>(
    builder:(context,data,_){
      print("it has to be ${data.notificationCount}");
      return icon(Provider.of<Data>(context,listen: false).notificationCount);
    }
          ),label: "notification"),
          BottomNavigationBarItem(icon: Icon(Icons.person_sharp,size: 20.0,),label: "profile")],
        currentIndex: selectedIndex,
        selectedItemColor: Color(0xffa450f8),
        unselectedItemColor: Color.fromARGB(255, 69, 22, 99),
        onTap: onItemTapped,
        selectedLabelStyle: TextStyle(color: Colors.white,fontSize: 1.0),
        unselectedLabelStyle:  TextStyle(color: Colors.white,fontSize: 1.0),
      ),
    );
  }
}
