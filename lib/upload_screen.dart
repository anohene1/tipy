import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:login_app4/home_screen.dart';
import 'package:login_app4/tipy_icons_icons.dart';

import 'main.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:getflutter/getflutter.dart';
import 'package:firebase_image/firebase_image.dart';
import 'dart:math';
import 'size_config.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neumorphic/neumorphic.dart';

File image;
List<File> images = [];
int count = 0;
Color col = Colors.green;

class UploadScreen extends StatefulWidget {
  static const id = 'upload_screen';

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  List<Widget> children = [];

  Future incrementCounter() async {
   count = count + 1;
  }

  Future getGalleryImage() async {
    var gallery = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (gallery != null) {
      images.add(gallery);
      setState(() {
        children.add(UploadCard(images[count]));
      });
    }
  }

  Future getGalleryVideo() async {
    var gallery = await ImagePicker.pickVideo(source: ImageSource.gallery);
    if (gallery != null) {
      images.add(gallery);
      setState(() {
        children.add(UploadCard(images[count]));
      });
    }
  }

  Future getCameraImage() async {
    var camera = await ImagePicker.pickImage(source: ImageSource.camera);
    if (camera != null) {
      images.add(camera);
      setState(() {
        children.add(UploadCard(images[count]));
      });
    }
  }

  void addCard() {
    setState(() {
      children.add(UploadScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.green,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(14),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: 50,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(150),
                            image: DecorationImage(
                                image: FirebaseImage(
                                    'gs://tipy-98639.appspot.com/profile_pics/${Uid}'))),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          image: DecorationImage(
                              image: AssetImage('images/dp.png')),
                          borderRadius: BorderRadius.circular(150)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'NAME',
                            style: TextStyle(
                                fontFamily: 'myriadpro',
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Your request will be completed soon",
                            maxLines: 20,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                                fontFamily: 'myriadpro', fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                NeuCard(child: GestureDetector(
                  onTap: (){
                    getCameraImage();
                  },
                  child: Container(
                    height: 80,
                    width: 80,
                    child: Column(
                      children: <Widget>[
                        Icon(TipyIcons.camera_1, size: 40),
                        Text('Camera', style: TextStyle(fontFamily: 'myriadpro'))
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                ),
                  curveType: CurveType.concave,
                  decoration: NeumorphicDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                ),
                  NeuCard(child: GestureDetector(
                    onTap: (){
                      getGalleryImage();
                    },
                    child: Container(
                      height: 80,
                      width: 80,
                      child: Column(
                        children: <Widget>[
                          Icon(TipyIcons.photo_2, size: 40),
                          Text('Photo', style: TextStyle(fontFamily: 'myriadpro'))
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ),
                  ),
                    curveType: CurveType.concave,
                    decoration: NeumorphicDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  ),

                  NeuCard(child: GestureDetector(
                    onTap: (){
                      getCameraImage();
                    },
                    child: Container(
                      height: 80,
                      width: 80,
                      child: Column(
                        children: <Widget>[
                          Icon(TipyIcons.camera, size: 40),
                          Text('Camcorder', style: TextStyle(fontFamily: 'myriadpro'),)
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ),
                  ),
                    curveType: CurveType.concave,
                    decoration: NeumorphicDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  ),
                  NeuCard(child: GestureDetector(
                    onTap: (){
                      getCameraImage();
                    },
                    child: Container(
                      height: 80,
                      width: 80,
                      child: Column(
                        children: <Widget>[
                          Icon(TipyIcons.clacket, size: 40),
                          Text('Video' , style: TextStyle(fontFamily: 'myriadpro'))
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ),
                  ),
                    curveType: CurveType.concave,
                    decoration: NeumorphicDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                    child: ListView.separated(
                  itemCount: children.length,
                  itemBuilder: (context, index) {
                    return UploadCard(images[count]);
                  },
                  separatorBuilder: (context, index) {
                    ++count;
                    return SizedBox();
                  },
                )),
              ),
//              Expanded(
//                child: Container(
//                  child: ListView.builder(itemBuilder: (context, index){
//                    return UploadCard(images[count]);
//                  },
//                  itemCount: children.length,
//                  ),
//                ),
//              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget UploadCard(File pickedImage) {
  //getGalleryImage();
  return NeuCard(
    curveType: CurveType.concave,
    decoration: NeumorphicDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
    margin: EdgeInsets.all(14),
    child: Container(
      padding: EdgeInsets.all(14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                image: DecorationImage(image: FileImage(pickedImage))),
          ),
          Icon(
            TipyIcons.cloud_4,
            color: Colors.green,
            size: 50,
          )
        ],
      ),
    ),
  );
}
