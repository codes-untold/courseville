import 'package:courseville/Networking/CourseFetch.dart';
import 'package:courseville/Screens/SearchScreen.dart';
import 'package:courseville/Widgets/GridWidget.dart';
import 'package:flutter/material.dart';

class  HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {

  String searchTerm;
  List <Widget> kTabPages;
  TabController tabController;

  final ktabs = <Tab>[Tab(child: Text("All"),),Tab(child: Text("Popular"),),Tab(child: Text("Top"),),];



      @override
      void dispose() {
        tabController.dispose();
        super.dispose();
  }

  @override
  void initState() {
 // tabController = TabController(length: ktabs.length, vsync: this);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    kTabPages = <Widget>[Center(child: GridWidget(category: "all",searchTerm: searchTerm,),),
      Center(child:  GridWidget(category: "popular",searchTerm: searchTerm,),),
      Center(child: GridWidget(category: "top",searchTerm: searchTerm,),)];

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
                                   Icons.apps_outlined,
                                   color: Colors.white,
                                 ),
                                 onTap: (){
                                   setState(() {
                                        searchTerm = null;

                                   });

                                 },
                               ),
                               GestureDetector(
                                 onTap: ()async{
                                 var searchName = await Navigator.push(context, MaterialPageRoute(builder: (context){
                                     return SearchScreen();
                                   }));
                                 if(searchName != null){
                                   print(searchName);
                                   setState(() {
                                     searchTerm = searchName;
                                     tabController.animateTo(2);
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
                  child: TabBarView(
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
