import 'package:courseville/Screens/RegistrationScreen.dart';
import 'package:flutter/material.dart';

import 'LoginScreen.dart';
import 'WelcomeScreen.dart';

class ForgotScreen extends StatelessWidget {
 // final _auth = FirebaseAuth.instance;
  bool loading = false;
  String email;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  double WIDTH =1000;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Form(
                  key:  _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Forgot Password?",
                        style: TextStyle(
                            fontSize: 18.0
                        ),),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (value){
                          if(value.isEmpty){
                            return "Email is required";
                          }

                          if(!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(value)){
                            return "Please enter a valid email address";
                          }
                          return null;
                        },
                        onSaved: (value){
                      //    email = value;
                        },
                        decoration: InputDecoration(
                            labelText: "Email Address",
                            filled: true,
                            contentPadding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                            prefixIcon: Icon(Icons.mail_outline),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none
                            )
                        ),
                      ),

                      SizedBox(
                        height: 10.0,
                      ),
                      RaisedButton(
                        onPressed: ()async{
/*
                          if(!_formkey.currentState.validate()){
                            return;
                          }

                          _formkey.currentState.save();
                          setState(() {
                            loading = true;
                          });

                          try {
                            await  _auth.sendPasswordResetEmail(email: email);
                            setState(() {
                              loading = false;
                            });

                            Fluttertoast.showToast(
                                msg: "Reset link has been sent to your email",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                textColor: Colors.white,
                                fontSize: 12.0
                            );
                          } on Exception catch (e) {

                            if(e.toString().contains("USER_NOT_FOUND")){
                              setState(() {
                                loading = false;
                              });

                              Fluttertoast.showToast(
                                  msg: "User not Found",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  textColor: Colors.white,
                                  fontSize: 12.0
                              );
                            }

                          }*/
                        },
                        padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                        child: Text("Reset Password",
                          style: TextStyle(
                              color: Colors.white
                          ),),
                        color:  Color(0xffa450f8),

                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                            return RegistrationScreen();
                          }));
                        },
                        child: Text("I haven't an account",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              decoration: TextDecoration.underline
                          ),),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
