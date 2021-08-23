
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Data extends ChangeNotifier{


  String auth;
  User userInfo;
  String searchTerm;
  List <bool> favourite;
  //List<List<String>> videoID;
  int videoID =0;


  void updateText(String text){
    auth = text;

    notifyListeners();
  }

  void updateUser(User user){
    userInfo = user;
    notifyListeners();
  }

void updateSearch(String search){
    searchTerm = search;
    notifyListeners();
}

  void addFavouriteList(List fav){
    favourite = fav;
    notifyListeners();

  }

  void UpdateFavouriteList(int index,bool value){
    favourite[index] = value;
    notifyListeners();
  }

  void updateCurrentVideoID(int value){
    videoID = value;
    notifyListeners();
  }
}