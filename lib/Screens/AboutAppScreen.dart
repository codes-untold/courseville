import 'package:flutter/material.dart';

class AboutAppScreen extends StatefulWidget {


  @override
  _AboutAppScreenState createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  Image logo1,logo2,logo3;

  @override
  void initState() {
    super.initState();
    logo1 = Image.asset("images/welcomepic1.png",gaplessPlayback: true,);
    logo2 = Image.asset("images/welcomepic2.png",gaplessPlayback: true,);
    logo3 = Image.asset("images/welcomepic3.png",gaplessPlayback: true,);  }



  @override
  void didChangeDependencies() {
    precacheImage(logo1.image, context);
    precacheImage(logo2.image, context);
    precacheImage(logo3.image, context);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 69, 22, 99),
        title: Text("About App"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: ListView(
                shrinkWrap: true,
                children: [
                  ConstrainedBox(
                      constraints: BoxConstraints.tightFor(width: 200,height: 200),
                      child: Image(image: logo1.image,gaplessPlayback: true,)),
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
                            Text("Organised Learning💡",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700
                            ),),
                            SizedBox(height: 10,),

                            Text("Courseville offers you a seamless learning experience"
                                " by presenting to you a variety of curated videos in the"
                                " order of their complexity to give you better understanding"
                                " in your course area."),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30,),
                  Image(image: logo2.image,gaplessPlayback: true,),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Course Articles📙",style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700
                            ),),
                            SizedBox(height: 10,),
                            Text("You also get access to tons of useful resources- "
                                "(Ebooks, Graphical illustrations) to assist you in"
                                " your learning journey."),
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
                  ConstrainedBox(
                      constraints: BoxConstraints.tightFor(width: 200,height: 200),
                      child: Image(image: logo3.image,gaplessPlayback: true,)),
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

                            Text("Ease of Learning👨‍🎓",style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700
                            ),),
                            SizedBox(height: 10,),
                            Text("You don't have to be in a hurry. From the comfort"
                                " of whereever, you can take our courses, relax and take a break,"
                                " then revisit the course again."),
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
       Container(
         width: double.infinity,
         color: Colors.black87,
         child: Center(child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: Text("CourseVille 1.0",style: TextStyle(color: Colors.white,fontSize: 15),),
         )),
       ) ],
      ),
    );
  }
}
