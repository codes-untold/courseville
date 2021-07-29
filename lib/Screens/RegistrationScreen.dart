import 'package:courseville/Networking/Authentication.dart';
import 'package:courseville/Screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  double WIDTH =1000;
  bool _obscureText1 = true;
  bool loading = false;
  String username;
  String email;
  String password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  void toggle1(){
    setState(() {
      if(_obscureText1){
        _obscureText1 = false;
      }
      else{
        _obscureText1 = true;
      }

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
                      flex:3,
                      child: Container(
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text("Create account",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),

                          SizedBox(
                            height: 20.0,
                          ),

                          Flexible(
                            child: Material(
                              shadowColor: Colors.black,
                              elevation: 0.5,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              child: TextFormField(
                                validator: (value){
                                  if(value.isEmpty){
                                    return "Username is Required";
                                  }
                                  return null;
                                },
                                onSaved: (value){
                                  username = value;
                                },
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    labelText: "Username",
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
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Flexible(
                            child: Material(
                              shadowColor: Colors.black,
                              elevation: 2.5,
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
                                    prefixIcon: Icon(Icons.mail,color: Colors.black,),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                        borderSide: BorderSide.none
                                    )
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          Flexible(
                            child: Material(
                              shadowColor: Colors.black,
                              elevation: 4.5,
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
                                obscureText: _obscureText1,
                                decoration: InputDecoration(
                                    labelText: "Password",
                                    contentPadding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: Icon(Icons.lock,color: Colors.black,),
                                    suffixIcon: IconButton(
                                           onPressed: (){
                                             toggle1();

                                           },
                                      icon: Icon(_obscureText1 == true? Icons.visibility_off:Icons.visibility),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                        borderSide: BorderSide.none
                                    )
                                ),
                              ),
                            ),
                          ),

                          Flexible(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.0625,
                            ),
                          ),
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Create",
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
                                    createUser(username, email, password);
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
                          Text("Already have an account?"),
                          SizedBox(width: 2,),
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Text("Sign In",
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
            ),
            Positioned(
              left:  MediaQuery.of(context).size.height * 0.025,
              top: MediaQuery.of(context).size.height * 0.0938,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: (){Navigator.pop(context);},

              ),
            ),  ],
        ),
      ),
    );
  }




  createUser(String username,email,password)async{
    if(!_formkey.currentState.validate()){
      return;
    }

    _formkey.currentState.save();
    setState(() {
      loading = true;
    });
    await Authentication().createUser(username, email, password).then((value){
      setState(() {
        loading = false;
      });
    });
  }
}

