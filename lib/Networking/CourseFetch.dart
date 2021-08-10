
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseFetch{

  List <Map<String,dynamic>> list = [];
  List <Map<String,dynamic>> searchList = [];
  bool state;
  List <QueryDocumentSnapshot> lister = [];

  Future <List <QueryDocumentSnapshot>> generalFetch(String user)async{

   await FirebaseFirestore.instance.collection(user).get().then((querySnapshot){
     querySnapshot.docs.forEach((element) {
       if(element.data()["name"]!= null){

         lister.add(element);

       }

     });

    });
   return lister;
  }

  Future <List <QueryDocumentSnapshot>> popularFetch(String user)async{

    await FirebaseFirestore.instance.collection(user).where("category",isEqualTo: "popular").get().then((querySnapshot){
      list.clear();
      querySnapshot.docs.forEach((element) {
        lister.add(element);

      });

    });
    return lister;
  }

  Future <List <QueryDocumentSnapshot>> topFetch(String user)async{

    await FirebaseFirestore.instance.collection(user).where("category",isEqualTo: "Top").get().then((querySnapshot){
      list.clear();
      querySnapshot.docs.forEach((element) {
        lister.add(element);

      });

    });
    return lister;
  }

  Future <List <QueryDocumentSnapshot>> searchFetch(String user,String search)async{

    await FirebaseFirestore.instance.collection(user).get().then((querySnapshot){

      querySnapshot.docs.forEach((element) {
        if(element.data()["name"]!= null){

          lister.add(element);

        }

      });

     lister.removeWhere((element) {
       //print(element.data());
       String data = (element.data()["name"]);


       if(!(data.toLowerCase().contains(search.toLowerCase())))
         {
           return true;
         }
       else{
         return false;
       }
     });


    });
    return lister;
  }
}