import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  Image logo,logo2;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final currencyController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    logo = Image.asset("images/avatar.jpg", gaplessPlayback: true,);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 69, 22, 99),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 30,),
              Container(
                width: double.infinity,
                child: CircleAvatar(
                  backgroundColor: Color(0xffe4c5f1),
                  radius: 80,
                  child:  Image.asset("images/avatar2.png",width: 120,gaplessPlayback: true,),
                ),
              ),
              SizedBox(height: 15,),
              Text("Support Courseville🎁",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700
              ),),
              SizedBox(height: 30,),
              Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
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

                          },
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              labelText: "Name",
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

                            return null;
                          },
                          onSaved: (value){

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

                          },
                          validator: (value){
                            if(value.isEmpty){
                              return "Phone";
                            }

                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              labelText: "Phone No",
                              contentPadding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                              prefixIcon: Icon(Icons.call,color: Colors.black,),
                              fillColor: Colors.white,
                              filled: true,
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

                          },
                          validator: (value){
                            if(value.isEmpty){
                              return "Phone";
                            }

                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              labelText: "NGN",
                              hintText: "Amount",
                              contentPadding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                              prefixIcon: Icon(Icons.monetization_on,color: Colors.black,),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide.none
                              )
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
