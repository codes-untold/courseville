
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseFetch{

  List <Map<String,dynamic>> list = [];
  List <Map<String,dynamic>> searchList = [];
  bool state;

  Future <List <Map<String,dynamic>>> generalFetch()async{

   await FirebaseFirestore.instance.collection("Admin").get().then((querySnapshot){
     list.clear();
     querySnapshot.docs.forEach((element) {
       list.add(element.data());

     });

    });
   return list;
  }

  Future <List <Map<String,dynamic>>> popularFetch()async{

    await FirebaseFirestore.instance.collection("Admin").where("category",isEqualTo: "popular").get().then((querySnapshot){
      list.clear();
      querySnapshot.docs.forEach((element) {
        list.add(element.data());

      });

    });
    return list;
  }

  Future <List <Map<String,dynamic>>> topFetch()async{

    await FirebaseFirestore.instance.collection("Admin").where("category",isEqualTo: "Top").get().then((querySnapshot){
      list.clear();
      querySnapshot.docs.forEach((element) {
        list.add(element.data());

      });

    });
    return list;
  }

  Future <List <Map<String,dynamic>>> searchFetch(String search)async{

    await FirebaseFirestore.instance.collection("Admin").get().then((querySnapshot){
      list.clear();
      querySnapshot.docs.forEach((element) {
        list.add(element.data());

      });

     list.removeWhere((element) {
       if(!(element["name"] as String).toLowerCase().contains(search.toLowerCase()))
         {
           return true;
         }
       else{
         return false;
       }
     });
     print(list);

    });
    return list;
  }
}