import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 69, 22, 99),
        title: Text("About App"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset("images/welcomepic1.png",width: 200,),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Organised Learning",style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700
                        ),),
                        SizedBox(height: 10,),
                        Text("hvghvhvhv"
                            "vjhkjhjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj"
                            "jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj"
                            "jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj"),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 30,),
              Image.asset("images/welcomepic2.png",width: 200,),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Course Articles",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700
                        ),),
                        SizedBox(height: 10,),
                        Text("hvghvhvhv"
                            "vjhkjhjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj"
                            "jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj"
                            "jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj"),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
              SizedBox(height: 30,),
              Image.asset("images/welcomepic3.png",width: 180,),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text("Ease of Learning",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700
                        ),),
                        SizedBox(height: 10,),
                        Text("hvghvhvhv"
                            "vjhkjhjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj"
                            "jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj"
                            "jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj"),
                      ],
                    ),
                  ),

                ],
              ),

              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
