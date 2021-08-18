import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseville/Constants.dart';
import 'package:courseville/Services/Listener.dart';
import 'package:courseville/Widgets/CourseListTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Services.dart';

class CourseScreen extends StatefulWidget {
  QueryDocumentSnapshot queryDocumentSnapshot;
  String user;
  int index;

  CourseScreen({this.queryDocumentSnapshot,this.user,this.index});

  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  double WIDTH = 200;

  Color color;


  @override
  void initState() {
    super.initState();
    print(widget.queryDocumentSnapshot.data()["coursevideo"]);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var providerData = Provider.of<Data>(context,listen: false);
    if(providerData.favourite[widget.index]){
    color = Colors.amber;
    }
    else{
    color = Colors.white;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 15),
            child: Column(
              children: [
                Container(
                  child: CachedNetworkImage(
                    width: 250,
                    imageUrl: widget.queryDocumentSnapshot.data()["image"],
                    placeholder: (context,url) => Icon(Icons.auto_stories,size: MediaQuery.of(context).size.width *0.3,
                      color: Colors.black12,),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 18,right: 18),
                  child: Column(
                     mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("By Leo Natsume",
                            style: TextStyle(
                              // color: Colors.white
                            ),),

                          SizedBox(
                            width: 5,
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints.tightFor(height: 15,width: 15),
                            child: CircleAvatar(
                                backgroundImage: AssetImage("images/tutorimage.jpeg"),
                                radius:  MediaQuery.of(context).size.width * 0.1388,
                                backgroundColor: Colors.white
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Text(widget.queryDocumentSnapshot.data()["name"],
                          style: Constants.courseTextstyle2),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Row(children: [
                            Icon(
                              Icons.favorite,
                              color: Colors.amber,
                            ),
                            Text("2.1k",
                              style: Constants.courseTextstyle,)
                          ],),

                          SizedBox(width: 50,),
                          Row(children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            Text("4.8",
                              style: Constants.courseTextstyle,
                            )
                          ],),
                        ],
                      ),
                      SizedBox(height: 25,),
                      Text("About this course",
                          style: Constants.courseTextstyle3),

                      SizedBox(height: 12,),

                      Text(widget.queryDocumentSnapshot.data()["description"],
                        style: Constants.courseTextstyle4,),
                      SizedBox(height: 25,),

                      Center(
                        child: Icon(Icons.arrow_drop_down_circle,
                          color: Color.fromARGB(255, 69, 22, 99),),
                      ),

                      SizedBox(height: 15,),


                      ListView.builder(
                        shrinkWrap: true,
                          itemCount: (widget.queryDocumentSnapshot.data()["coursevideo"] as List)?.length,
                          itemBuilder: (context,i){
                        return CourselistTile(queryDocumentSnapshot: widget.queryDocumentSnapshot,i: i,);
                      }),


                      SizedBox(height: 15,),


                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                            return CourseScreen(queryDocumentSnapshot:widget.queryDocumentSnapshot,
                              user: widget.user,index:widget.index);
                          }));
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          color: Color(0xffa450f8),
                          child: Center(
                            child: Text("Start Course",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white
                              ),),
                          ),
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight:Radius.circular(30))
                  ),
                )
              ],
            ),
          ),
        )
      ),
   floatingActionButton: Consumer<Data>(
     builder: (context,data,child){
       return FloatingActionButton(
         onPressed: ()async{
           var providerData = Provider.of<Data>(context,listen: false);
           if(data.favourite[widget.index]){
             color = Colors.white;
             providerData.UpdateFavouriteList(widget.index, false);
             Services().showInSnackBar("${widget.queryDocumentSnapshot.data()["name"]} Removed from Favourites•☹️",context);
             await FirebaseFirestore.instance.collection(
                 widget.user).doc(
                 widget.queryDocumentSnapshot.id
             ).update({"favourite": false});
           }

           else{
             color = Colors.amber;
             providerData.UpdateFavouriteList(widget.index, true);
             Services().showInSnackBar("${widget.queryDocumentSnapshot.data()["name"]} Added to Favourites😀",context);
             await FirebaseFirestore.instance.collection(
                 widget.user).doc(
                 ( widget.queryDocumentSnapshot.id)
             ).update({"favourite": true});
           }
         },
         backgroundColor: Color.fromARGB(255, 69, 22, 99),
         child: Icon(Icons.favorite,
           color: color,),
       );
     },

   ), );
  }

  clickFavourite(BuildContext context ) async{
    if ( color == Colors.white) {
      setState(() {
        color = Colors.amber;
        print("on");
      });
      Services().showInSnackBar("${widget.queryDocumentSnapshot.data()["name"]} Added to Favourites😀",context);
      await FirebaseFirestore.instance.collection(
          widget.user).doc(
          ( widget.queryDocumentSnapshot.id)
      ).update({"favourite": true});

    }

    else {
      setState(() {
        color = Colors.white;
        print("off");
      });
      Services().showInSnackBar("${widget.queryDocumentSnapshot.data()["name"]} Removed from Favourites•☹️",context);

      await FirebaseFirestore.instance.collection(
          widget.user).doc(
          widget.queryDocumentSnapshot.id
      ).update({"favourite": false});
    }
  }
}

