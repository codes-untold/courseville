import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class CourseCard extends StatelessWidget {

  final Map <String,dynamic> querySnapshot;

  CourseCard({@required this.querySnapshot});

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
                  imageUrl: querySnapshot["image"],
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
                         Text((querySnapshot["name"] as String).length > 18 ?
                         "${(querySnapshot["name"] as String).substring(0,15)}...":
                         querySnapshot["name"],style: TextStyle(
                           fontWeight: FontWeight.w500,
                           fontSize: 13
                         ),),
                         Text("${querySnapshot["videos"]} Videos",style:
                           TextStyle(
                             fontSize: 10
                           ),),
                       ],
                     ),
                 Icon(Icons.favorite,
                   color: Color(0xffa450f8)),
               ],
                 ),
               )) ],
        ),
      ),
    );
  }
}
