
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:courseville/Services/Utils.dart';
import 'package:courseville/Widgets/Certificate.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'WidgetToImage.dart';

// ignore: must_be_immutable
class CertificateScreen extends StatelessWidget {

  String username;
  String coursename;
  GlobalKey key1;
  Uint8List bytes1;

  CertificateScreen({this.coursename,this.username});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color.fromARGB(255, 69, 22, 99),
      ),
      body: SafeArea(
        child: Center(
          child: WidgetToImage(
            builder: (key){
              this.key1 = key;
              return Certificate(username: username, coursename: coursename);
            },
          ),
         ),

      ),
        floatingActionButton: FloatingActionButton(
              onPressed: ()async{
            bool isPermitted = await Permission.storage.isGranted;
            if(isPermitted)exportCertificate();
              else{
              await Permission.storage.request().then((value) => exportCertificate());
            }
              },
              backgroundColor: Color.fromARGB(255, 69, 22, 99),
              child: Icon(Icons.download_sharp,
                color: Colors.white),
            )
    );
  }

  
  //exports certificate to an external directory in device
  void exportCertificate()async{
    final bytes1 = await Utils.capture(key1);
    Directory documentDirectory = await getExternalStorageDirectory();
    new Directory(documentDirectory.path).create(recursive: true).then((Directory directory) async{
      File file = await new File("${directory.path}/$coursename.jpg").create(recursive: true);
      await file.writeAsBytes(bytes1).then((value) {
        Utils().displayToast("Saved to ${directory.path}/");
      }).onError((error, stackTrace){ Utils().displayToast("An error occured");});

    });

  }
}


