
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseville/Services/Listener.dart';
import 'package:courseville/Widgets/CourseCards.dart';
import 'package:courseville/Widgets/FavouriteCard.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';

import '../CustomPainter.dart';
import '../Services.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  Data provider;
  String user;
  double WIDTH = 200;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<Data>(context,listen: false);
    Services().getBoolToSF().then((value) {
      setState(() {
        user = value[0];
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     /* appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 69, 22, 99),
        title: Text("Favourites"),
        centerTitle: true,
      ),*/
          body: SafeArea(
            child: Stack(
              children: [
                Container(
                  child: CustomPaint(
                    size: Size(WIDTH,(WIDTH*2.5).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                    painter: RPSCustomPainter2(),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height:MediaQuery.of(context).size.height ,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child:  user==null?  CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 69, 22, 99)))
                      : PaginateFirestore(
                      onError: (e){
                        Services().displayToast("An error occured");
                        return null;
                      },

                      itemsPerPage: 1,
                      itemBuilderType: PaginateBuilderType.listView,
                      itemBuilder: (index,context,documentsnapshot){
// Color(0xffa450f8)
                        return Column(
                          children: [
                            FavouriteCard(queryDocumentSnapshot: documentsnapshot,index: index,user: user,),
                            SizedBox(
                              height: 10,
                            ) ],
                        );
                      },
                      query: FirebaseFirestore.instance.collection(user).where("favourite",isEqualTo: true)
                  ),
                ), ],
            )
          ),
    );
  }
}
