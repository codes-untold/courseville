
import 'package:courseville/Services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication{
  final _auth = FirebaseAuth.instance;
  Services services = Services();




Future <void> createUser(username,email,password)async{
  try {
    UserCredential newUser = await  _auth.createUserWithEmailAndPassword(email: email, password: password);
    if(newUser != null){
      await newUser.user.updateDisplayName(username).then((value)async{
        await newUser.user.sendEmailVerification().then((value){
          services.displayToast("Please check your email for verification");
        });
      });

    }
  } on Exception catch (e) {

    if(e.toString().contains("EMAIL_ALREADY_IN_USE")){
      services.displayToast("Email aleady exists");
    }

    if(e.toString().contains("NETWORK_REQUEST_FAILED")){
      services.displayToast("Network problem occured");
    }
  }
}



  bool checkEmail(String value){
    if(!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(value)){
      return false;
    }
    else{
      return true;
    }
      }


      Future <void> loginUser(String email,password)async{

        try {
          final newUser = await  _auth.signInWithEmailAndPassword(email: email, password: password);

          if(newUser != null) {
            if (newUser.user.emailVerified) {
              print(_auth.currentUser.uid);
              services.displayToast("Email  verified");
            }
            else {
              services.displayToast("Email not verified");
            }
          }
        } on Exception catch (e) {
          print(e.toString());
          if(e.toString().contains("network-request-failed")){
            services.displayToast("Network problem occured");
          }

          if(e.toString().contains("The password is invalid")){
            services.displayToast("Incorrect password");

          }
          if(e.toString().contains("no user record")){
            services.displayToast("User not found");
          }
        }
      }

      Future <void> resetEmail(email)async{
        try {
          await  _auth.sendPasswordResetEmail(email: email);
          services.displayToast(" Reset link has been sent to your email");
          print("working");


        } on Exception catch (e) {
          print(e.toString());
          if(e.toString().contains("no user record")){
            services.displayToast("User not found");
          }

          if(e.toString().contains("network-request-failed")){
            services.displayToast("Network problem occured");
          }

        }
      }
}