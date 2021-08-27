import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseville/Screens/CourseIntro.dart';
import 'package:courseville/Screens/CourseScreen.dart';
import 'package:courseville/Services/Listener.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Services.dart';


class CourseCard extends StatefulWidget {

  final QueryDocumentSnapshot querySnapshot;
  String user;
  int cardindex;
  int totalCards;

  CourseCard({@required this.querySnapshot,this.user,this.cardindex,this.totalCards});

  @override
  _CourseCardState createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {

  IconData icon;

  @override
  void initState() {
    super.initState();

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.dependOnInheritedWidgetOfExactType();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return CourseScreen(queryDocumentSnapshot: widget.querySnapshot,user: widget.user,courseScreenIndex: widget.cardindex,);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(16.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [

              Expanded(
                flex: 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(16.0),topLeft: Radius.circular(16.0)),
                  child: Hero(
                    tag: widget.querySnapshot.data()["name"],
                    child: CachedNetworkImage(
                      imageUrl: widget.querySnapshot.data()["image"],
                      placeholder: (context,url) => Icon(Icons.auto_stories,size: MediaQuery.of(context).size.width *0.3,
                        color: Colors.black12,),
                    ),
                  ),
                ),
              ),
             SizedBox(
               height: 10,
             ),
             Flexible(
                 flex: 2,
                 child: Padding(
                   padding: const EdgeInsets.only(left: 10,right: 10),
                   child: Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Column(
                         //
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text((widget.querySnapshot.data()["name"] as String).length > 18 ?
                           "${(widget.querySnapshot.data()["name"] as String).substring(0,15)}...":
                           widget.querySnapshot["name"],style: TextStyle(
                             fontWeight: FontWeight.w500,
                             fontSize: 13
                           ),),
                           Text("${widget.querySnapshot.data()["videos"]} Videos",style:
                             TextStyle(
                               fontSize: 10
                             ),),
                         ],
                       ),
                   GestureDetector(
                     onTap: work,
                     child: Consumer<Data>(
                       builder:(context,data,child){
                         return Icon(!(data.favourite.length < widget.totalCards)?
                         data.favourite[widget.cardindex]? Icons.favorite_rounded: Icons.favorite_border_rounded:Icons.favorite_border_rounded,
                             color: Color(0xffa450f8));
                       },
                     ),
                   ),
                 ],
                   ),
                 )) ],
          ),
        ),
      ),
    );
  }
  void work()async{
      var providerData = Provider.of<Data>(context,listen: false);
    if ( providerData.favourite[widget.cardindex] == false) {
      providerData.UpdateFavouriteList(widget.cardindex, true);
      Services().showInSnackBar("${widget.querySnapshot.data()["name"]} Added to Favourites😀",context);
      await FirebaseFirestore.instance.collection(
          widget.user).doc(
          ( widget.querySnapshot.id)
      ).update({"favourite": true});

    }

    else {
     providerData.UpdateFavouriteList(widget.cardindex, false);
      Services().showInSnackBar("${widget.querySnapshot.data()["name"]} Removed from Favourites•☹",context);
      await FirebaseFirestore.instance.collection(
          widget.user).doc(
          widget.querySnapshot.id
      ).update({"favourite": false});
    }
  }

}



