import 'package:courseville/Networking/Authentication.dart';
import 'package:courseville/Screens/HomeScreen.dart';
import 'package:courseville/Screens/RegistrationScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ForgotScreen.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  String password;
  String email;
  double WIDTH =1000;
  bool loading = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  void toggle(){
    setState(() {
      if(_obscureText){
        _obscureText = false;
      }
      else{
        _obscureText = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: loading,
        child: Stack(
          children: [
            Container(
              child: CustomPaint(
                size: Size(WIDTH,(WIDTH*2.5).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                painter: RPSCustomPainter2(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height:MediaQuery.of(context).size.height ,
                ),
              ),
            ),
         Padding(
           padding: const EdgeInsets.all(20.0),
           child: Form(
             key: _formkey,
             child: Column(
               children: [
                 Flexible(
                   flex:2,
                   child: Container(
                   ),
                 ),
                 Expanded(
                   flex: 7,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                       Text("Hello",
                         textAlign: TextAlign.center,
                         style: TextStyle(fontSize: 65,fontWeight: FontWeight.w900),),
                       Text("Sign in to your account",
                         textAlign: TextAlign.center,
                         style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),

                       SizedBox(
                         height: 40.0,
                       ),
                       Material(
                         elevation: 0.5,
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(20),
                         child: TextFormField(
                           keyboardType: TextInputType.emailAddress,
                           validator: (value){
                             if(value.isEmpty){
                               return "Email is required";
                             }

                             if(!Authentication().checkEmail(value)){
                               return "Please enter a valid email address";
                             }
                             return null;
                           },
                           onSaved: (value){
                             email = value;
                           },
                           decoration: InputDecoration(
                              fillColor: Colors.white,
                               labelText: "Email Address",
                               filled: true,
                               contentPadding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                               prefixIcon: Icon(Icons.person,color: Colors.black,),
                               border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(20.0),
                                   borderSide: BorderSide.none
                               )
                           ),
                         ),
                       ),

                       SizedBox(
                         height: 10.0,
                       ),
                       Material(
                         elevation: 2.5,
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(20),
                         child: TextFormField(
                           onChanged: (value){
                             password = value;
                           },
                           validator: (value){
                             if(value.isEmpty){
                               return "Password is Required";
                             }
                             if(value.length<6){
                               return "Password should be at least six characters";
                             }
                             return null;
                           },
                           keyboardType: TextInputType.visiblePassword,
                           obscureText: _obscureText,
                           decoration: InputDecoration(
                               labelText: "Password",
                               contentPadding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                               fillColor: Colors.white,
                               filled: true,
                               prefixIcon: Icon(Icons.lock,color: Colors.black,),
                               suffixIcon: IconButton(
                                 onPressed: toggle,
                                 icon: Icon(_obscureText == true? Icons.visibility_off:Icons.visibility),
                               ),
                               border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(20.0),
                                   borderSide: BorderSide.none
                               )
                           ),
                         ),
                       ),
                       SizedBox(
                         height: 10.0,
                       ),
                       Container(
                         child: GestureDetector(
                           onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context){
                               return ForgotScreen();
                             }));
                           },
                           child: Text("Forgot Password?",
                             textAlign: TextAlign.right,),
                         ),
                       ),
                       Flexible(
                         child: SizedBox(
                           height: 50,
                         ),
                       ),
                       Flexible(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                           children: [
                             Text("Sign in",
                             style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: 20
                             ),),
                             SizedBox(
                               width: 5,
                             ),
                             ConstrainedBox(
                               constraints: BoxConstraints.tightFor(
                                 width: 50,
                                  height: 35
                               ),
                               child: ElevatedButton(onPressed: (){

                                    login(email, password);
                               },
                                   child: Icon(Icons.arrow_forward),
                               style: ButtonStyle(
                                 backgroundColor: MaterialStateProperty.all(
                                     Color(0xffa450f8)
                                 ) ,
                                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                   RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(18),
                                   )
                                 )
                               ),),
                             )
                           ],
                         ),
                       )
                     ],
                   ),
                 ),
             Expanded(
               flex: 1,
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text("Don't have an account?"),
                   SizedBox(width: 2,),
                   GestureDetector(
                     onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context){
                         return RegistrationScreen();
                       }));

                     },
                     child: Text("Create",
                     style: TextStyle(
                       fontWeight: FontWeight.bold,
                       decoration: TextDecoration.underline
                     ),),
                   ),
                 ],
               ),
             )  ],
             ),
           ),
         ) ],

        ),
      ),
    );
  }


  void login(email,password)async{
    if(!_formkey.currentState.validate()){
      return;
    }

    _formkey.currentState.save();
    setState(() {
      loading = true;
    });

    await Authentication().loginUser(email, password,context).then((value){
      setState(() {
        loading = false;
      });
    });
  }
}



class RPSCustomPainter2 extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {



    Paint paint_0 = new Paint()
      ..color = Color(0xffa450f8)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;


    Path path_0 = Path();
    path_0.moveTo(size.width,0);
    path_0.quadraticBezierTo(size.width*0.7425000,size.height*-0.0015000,size.width*0.6500000,0);
    path_0.quadraticBezierTo(size.width*0.5675000,size.height*0.0440000,size.width*0.6150000,size.height*0.0640000);
    path_0.quadraticBezierTo(size.width*0.7437500,size.height*0.0440000,size.width*0.7800000,size.height*0.0720000);
    path_0.cubicTo(size.width*0.8412500,size.height*0.1210000,size.width*0.5737500,size.height*0.1530000,size.width*0.7450000,size.height*0.1880000);
    path_0.cubicTo(size.width*0.8262500,size.height*0.2060000,size.width*0.8762500,size.height*0.1475000,size.width,size.height*0.1780000);
    path_0.quadraticBezierTo(size.width*1.0250000,size.height*0.1365000,size.width,0);
    path_0.close();

    canvas.drawPath(path_0, paint_0);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}

addBoolToSF(_auth)async{
  List <String> list = [_auth.currentUser.uid,_auth.currentUser.displayName];
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setStringList("UID", list);
  preferences.setBool("boolvalue", true);

}
