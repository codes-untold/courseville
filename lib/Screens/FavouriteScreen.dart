
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseville/Services/Constants.dart';
import 'package:courseville/Services/CustomPainter.dart';
import 'package:courseville/Services/Listener.dart';
import 'package:courseville/Services/Utils.dart';
import 'package:courseville/Widgets/FavouriteCard.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';



class FavouriteScreen extends StatefulWidget {
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  Data provider;
  String user;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<Data>(context,listen: false);
    Utils().getBoolToSF().then((value) {
      setState(() {
        user = value[0];
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

          body: SafeArea(
            child: Stack(
              children: [
                Container(
                  child: CustomPaint(
                    size: Size(Constants.customPaintWidth,(Constants.customPaintWidth*2.5).toDouble()),
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
                    initialLoader: Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 69, 22, 99)))),
                      emptyDisplay:Center(child: Text("You have no Favourites yet!")),
                      onError: (e){
                        Utils().displayToast("An error occured");
                        return null;
                      },
                      itemsPerPage: 1,
                      itemBuilderType: PaginateBuilderType.listView,
                      itemBuilder: (index,context,documentSnapshot){
                          return Column(
                            children: [
                              FavouriteCard(queryDocumentSnapshot: documentSnapshot,index: index,user: user,),
                              SizedBox(
                                height: 10,
                              ) ],
                          );
                      },
                      query: FirebaseFirestore.instance.collection(user).where(Constants.COURSE_FAVOURITE,isEqualTo: true)
                  ),
                ), ],
            )
          ),
    );
  }
}
