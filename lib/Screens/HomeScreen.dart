
import 'package:flutter/material.dart';
import 'package:courseville/Screens/SearchScreen.dart';
import 'package:courseville/Services/Listener.dart';
import 'package:courseville/Services/Utils.dart';
import 'package:courseville/Widgets/GridWidget.dart';
import 'package:provider/provider.dart';

class  HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  String searchTerm;
  List <Widget> kTabPages;
  TabController tabController;
  String user;
  Data userData;
  bool dataFetch = false;
  bool hasLoaded = false;

  final kTabs = <Tab>[Tab(child: Text("All"),),Tab(child: Text("Popular"),),Tab(child: Text("Top"),),];


      @override
      void dispose() {
        tabController.dispose();
        super.dispose();
  }

  @override
  void initState() {
    super.initState();
   userData = Provider.of<Data>(context, listen: false);
    user = userData?.userInfo?.uid;
    tabController = TabController(length: kTabs.length, vsync: this);
    Utils().getBoolToSF().then((value) {
      setState(() {
        user = userData?.userInfo?.uid ?? value[0];
        userData.updateText(userData?.userInfo?.displayName ?? value[1]);


      });
    });
  }

  @override
  Widget build(BuildContext context) {
    kTabPages = <Widget>[Center(child: GridWidget(category: "all",searchTerm: searchTerm,user: user,contextt: context,),),
      Center(child:  GridWidget(category: "popular",searchTerm: searchTerm,user: user,contextt: context,),),
      Center(child: GridWidget(category: "top",searchTerm: searchTerm,user: user,contextt: context,),)];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 69, 22, 99),
      body: SafeArea(
        child: DefaultTabController(
          length: kTabs.length,
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
                                   Icons.apps_outlined,
                                   color: Colors.white,
                                 ),
                                 onTap: () => Navigator.popAndPushNamed(context,'/NavigationScreen'),
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
                            Text("Hi ${userData.username}🖐️",style: TextStyle(
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
                          tabs:kTabs ,
                          labelColor: Colors.white,
                          indicatorColor: Colors.white,
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
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 20),
                  child: user==null?
    CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 69, 22, 99)))
                      :TabBarView(
                    controller: tabController,
                    children: kTabPages,
                  ),
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
