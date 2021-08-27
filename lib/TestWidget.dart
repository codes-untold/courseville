
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TestWidget extends StatefulWidget {



  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {

  @override
  void initState() {
    super.initState();
    work();
    print("dddd");
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
    );
  }

  work()async{



  }
}
