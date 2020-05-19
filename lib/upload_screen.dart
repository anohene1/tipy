import 'package:login_app4/home_screen.dart';
import 'package:login_app4/size_config.dart';

import 'main.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class UploadScreen extends StatefulWidget {


  static const id = 'upload_screen';




  @override
  _UploadScreenState createState() => _UploadScreenState();
}



class _UploadScreenState extends State<UploadScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.close, color: Colors.green,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
