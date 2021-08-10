import 'package:courseville/Networking/Authentication.dart';
import 'package:courseville/Screens/SearchScreen.dart';
import 'package:courseville/Services/Listener.dart';
import 'package:courseville/Widgets/GridWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Services.dart';

class  HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  String searchTerm;
  List <Widget> kTabPages;
  TabController tabController;
  String  user;
  String username;

  final ktabs = <Tab>[Tab(child: Text("All"),),Tab(child: Text("Popular"),),Tab(child: Text("Top"),),];



      @override
      void dispose() {
        tabController.dispose();
        super.dispose();
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: ktabs.length, vsync: this);
    Services().getBoolToSF().then((value) {
      setState(() {
        user = Provider
            .of<Data>(context, listen: false)
            .userInfo
            ?.uid ?? value[0];
        username = Provider
            .of<Data>(context, listen: false)
            .userInfo
            ?.displayName ?? value[1];

        Authentication().addUser(user).then((_) => null);

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    kTabPages = <Widget>[Center(child: GridWidget(category: "all",searchTerm: searchTerm,user: user,),),
      Center(child:  GridWidget(category: "popular",searchTerm: searchTerm,user: user,),),
      Center(child: GridWidget(category: "top",searchTerm: searchTerm,user: user,),)];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 69, 22, 99),
      body: SafeArea(
        child: DefaultTabController(
          length: ktabs.length,
          child: Column(
            children: [
              Expanded(child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 25,right: 16,top: 25,bottom: 10),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               GestureDetector(
                                 child: Icon(
                                   Icons.home_outlined,
                                   color: Colors.white,
                                 ),
                                 onTap: () => Navigator.popAndPushNamed(context,'/hommy'),
                               ),
                               GestureDetector(
                                 onTap: ()async{
                                 var searchName = await Navigator.push(context, MaterialPageRoute(builder: (context){
                                     return SearchScreen();
                                   }));
                                 if(searchName != null){
                                   setState(() {
                                     searchTerm = searchName;
                                     animate(tabController.index);
                                   });

                                 }
                                 },
                                 child: Icon(
                                     Icons.search,
                                   color: Colors.white,
                                 ),
                               ),
                             ],
                           ),
                            SizedBox(
                              height: 15,
                            ),
                            Text("Hi Xeroes🖐️",style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 25.0
                            ),),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Today is a good day",style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 13.0
                            ),),
                            SizedBox(
                              height: 2,
                            ),
                            Text("To learn something new!",style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 13.0
                            ),),

                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TabBar(

                          controller: tabController,
                          tabs:ktabs ,
                          labelColor: Colors.white,
                          indicatorColor: Colors.amberAccent,
                          indicatorSize: TabBarIndicatorSize.label,
                          labelStyle: TextStyle(
                            //   fontSize: 16
                          ),),
                      )
                    ],
                  ),
                ),
                color: Color.fromARGB(255, 69, 22, 99),
              ),
              flex: 4,),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 20),
                  child: user!=null?TabBarView(
                    controller: tabController,
                    children: kTabPages,
                  ):CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 69, 22, 99))),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight:Radius.circular(30))
                ),
              ),
                flex: 8,)
            ],
          ),
        ),
      ),
    );
  }

  animate(int value){
        switch (value){
          case 0: tabController.animateTo(2);
          print(value);
          break;
          case 1: tabController.animateTo(0);
          print(value);
          break;
          case 2:tabController.animateTo(1);
          print(value);
        }
  }
}
