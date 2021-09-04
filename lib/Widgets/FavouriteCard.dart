import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseville/Screens/CourseScreen.dart';
import 'package:flutter/material.dart';

class FavouriteCard extends StatelessWidget {

  QueryDocumentSnapshot queryDocumentSnapshot;
  int index;
  String user;


  FavouriteCard({this.queryDocumentSnapshot,this.index,this.user});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return CourseScreen(queryDocumentSnapshot: queryDocumentSnapshot,user: user,
            courseScreenIndex: index,canHandleFavouriteOperations: false,);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(16.0))),
          child: Container(
            height: 200,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(Icons.favorite,color: Color.fromARGB(255, 69, 22, 99),),
                Row(
                  children: [
                    Expanded(
                     flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: Row(
                             // crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text( queryDocumentSnapshot.data()["name"],style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20
                                      ),overflow: TextOverflow.clip,),
                                      SizedBox(height: 10,),
                                      Text(
                                      "${(queryDocumentSnapshot.data()["description"] as String).substring(0,65)}...",style:
                                      TextStyle(
                                          fontSize: 12
                                      ),),
                                      SizedBox(height: 10,),
                                      Text("${queryDocumentSnapshot.data()["videos"]} Videos",style:
                                      TextStyle(
                                          fontSize: 12,
                                        fontWeight: FontWeight.w700
                                      ),),
                                    ],
                                  ),
                                ),],
                            ),
                          ),
                      ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(16.0),topLeft: Radius.circular(16.0)),
                        child: CachedNetworkImage(
                          imageUrl: queryDocumentSnapshot.data()["image"],
                          width:MediaQuery.of(context).size.width *0.3 ,
                          placeholder: (context,url) => Icon(Icons.auto_stories,size: MediaQuery.of(context).size.width *0.3,
                            color: Colors.black12,),
                        ),
                      ),
                    ), ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
