import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: TextField(
            onSubmitted: (value){
              Navigator.pop(context,value);
            },
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey[200],
              labelText: "Search",
              contentPadding: EdgeInsets.only(top: 10,bottom: 10,left: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide.none
              )

            ),
          )
        ),
      ),
    );
  }
}
