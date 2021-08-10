import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class CourseCard extends StatefulWidget {

  final QueryDocumentSnapshot querySnapshot;
  String user;

  CourseCard({@required this.querySnapshot,this.user});

  @override
  _CourseCardState createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {

  IconData icon;

  @override
  void initState() {
    super.initState();
    if(widget.querySnapshot.data()["favourite"] == true){
      icon = Icons.favorite_rounded;
    }else{
      icon = Icons.favorite_border_rounded;
    }
  }
  @override
  Widget build(BuildContext context) {

    return Padding(
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
                child: CachedNetworkImage(
                  imageUrl: widget.querySnapshot.data()["image"],
                  placeholder: (context,url) => Icon(Icons.auto_stories,size: MediaQuery.of(context).size.width *0.3,
                    color: Colors.black12,),
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
                   child: Icon(icon,
                     color: Color(0xffa450f8)),
                 ),
               ],
                 ),
               )) ],
        ),
      ),
    );
  }
  void work()async{

    if (  icon == Icons.favorite_border_rounded) {
      icon = Icons.favorite_rounded;
      print("on");
      showInSnackBar("${widget.querySnapshot.data()["name"]} Added to Favourites😀");
      setState(()=>null);
      await FirebaseFirestore.instance.collection(
          widget.user).doc(
          ( widget.querySnapshot.id)
      ).update({"favourite": true});

    }

    else {
      icon = Icons.favorite_border_rounded;
      print("off");
      showInSnackBar("${widget.querySnapshot.data()["name"]} Removed from Favourites•☹️");
      setState(() {

      });
      await FirebaseFirestore.instance.collection(
          widget.user).doc(
          widget.querySnapshot.id
      ).update({"favourite": false});
    }
  }
  showInSnackBar(String text){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}



