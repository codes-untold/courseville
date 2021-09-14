
import 'package:flutter/material.dart';
import 'package:courseville/Services/PaymentConstants.dart';
import 'package:courseville/Services/Utils.dart';
import 'package:courseville/Widgets/AppreciationWidget.dart';
import 'package:flutterwave/core/flutterwave.dart';
import 'package:flutterwave/flutterwave.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class PaymentScreen extends StatefulWidget {


  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final amountController = TextEditingController();

  final nameController = TextEditingController();

  final phoneController = TextEditingController();

  final emailController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
   // popUpDialog(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 69, 22, 99),
      ),
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: loading,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                  child: Column(children: [
                    SizedBox(height: 30,),
                    Flexible(
                      child: Container(
                        width: double.infinity,
                        child: CircleAvatar(
                          backgroundColor: Color(0xffe4c5f1),
                          radius: 80,
                          child:  Image.asset("images/avatar2.png",width: 120,gaplessPlayback: true,),
                        ),
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
                      key: _formKey,
                      child: Flexible(
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
                                  controller: nameController,
                                  validator: (value){
                                    if(value.isEmpty){
                                      return "name is Required";
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
                                  controller: emailController,
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
                                  controller: phoneController,
                                  validator: (value){
                                    if(value.isEmpty){
                                      return "Enter your phone Number";
                                    }

                                    return null;
                                  },
                                  keyboardType: TextInputType.phone,
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
                                  controller: amountController,
                                  validator: (value){
                                    if(value.isEmpty){
                                      return "Enter Amount";
                                    }

                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
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
                            SizedBox(
                              height: 10,
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],),
                ),
                GestureDetector(
                  onTap: (){
                    if(this._formKey.currentState.validate()){
                      setState(() {
                        loading = true;
                      });
                      launchPayment(context);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    color: Color(0xffa450f8),
                    child: Center(
                      child: Text("Support",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white
                        ),),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void launchPayment(BuildContext context)async{


     Flutterwave flutterWave = Flutterwave.forUIPayment
       (fullName: nameController.text,
     context: context,
     publicKey: PaymentConstants.PUBLIC_KEY,
     encryptionKey: PaymentConstants.ENCRYPTION_KEY,
     email: emailController.text,
     txRef: DateTime.now().toString(),
     amount: amountController.text,
    phoneNumber: phoneController.text,
     currency: FlutterwaveCurrency.NGN,
     isDebugMode: false,
     acceptBankTransfer: true,
     acceptCardPayment: true,
     acceptUSSDPayment: true);

     final response = await flutterWave.initializeForUiPayments().then((value) {
       setState(() {loading = false;
       nameController.clear();
       emailController.clear();
       phoneController.clear();
       amountController.clear();
       });
     });

     if(response != null){
       {
         popUpDialog(context);
         print(response.data.status);}
     }else{
       Utils().displayToast("Unable to complete Transaction");
     }
  }

  //Shows up dialog upon successful payment
  popUpDialog(BuildContext context){
    showDialog(context: context, builder: (context){
      return Dialog(
        elevation: 16,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          child: AppreciationWidget(),

        ),
      );
    });
  }
}

