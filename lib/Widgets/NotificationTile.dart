
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {


   String notificationImage;
   String notificationMessage;

   NotificationTile({this.notificationImage,this.notificationMessage});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        elevation: 5,
        child: ClipPath(
          clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              )
          ),
          child: ListTile(
            //    contentPadding: EdgeInsets.only(bottom: 3),
            leading: notificationImage == null? ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Image.asset("images/avatar.jpg",width: 40,gaplessPlayback: true,),
            ):CachedNetworkImage(
              imageUrl: notificationImage,
              placeholder: (context,url) => Icon(Icons.auto_stories,size: MediaQuery.of(context).size.width *0.1,
                color: Colors.black12,),
            ),
            title: Text(notificationMessage,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400
              ),),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text("",
                style: TextStyle(
                    fontSize: 11
                ),),
            ),
            tileColor: Colors.white,
            trailing: Icon(Icons.info,
              color: Color.fromARGB(255, 69, 22, 99),),

          ),
        ),

      ),
    );
  }
}
