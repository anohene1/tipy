import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:login_app4/home_screen.dart';
import 'package:login_app4/size_config.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_image/firebase_image.dart';



final StorageReference profilePic = FirebaseStorage.instance.ref().child('profile_pic');

class ProfileScreen extends StatefulWidget {




  static const id = 'profile_screen';




  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}



class _ProfileScreenState extends State<ProfileScreen> {
  String imageLoc;
  File _image;
  FirebaseImage pic = FirebaseImage('gs://tipy-98639.appspot.com/profile_pic');
  Future getCameraImage() async{
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    if(picture != null){
      cropImage(picture);
    }
  }
  Future getGalleryImage() async{
    var gallery = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(gallery != null){
      cropImage(gallery);
    }
  }

  Future cropImage(File image) async{
    File croppedImage = await ImageCropper.cropImage(
        sourcePath: image.path,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    if(croppedImage != null){
      _image = croppedImage;
      final StorageUploadTask task = profilePic.putFile(_image);
      await task.onComplete;

      setState(() {
      });
    }
  }

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
          title: Text(
            'Profile Options',
            style: TextStyle(
              fontFamily: 'myriadpro',
              fontSize: SizeConfig.blockSizeVertical * 2,
              color: Colors.black
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 4),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    child:Container(
                      height: SizeConfig.blockSizeHorizontal * 50,
                      width: SizeConfig.blockSizeHorizontal * 50,
                      //child: Image.file(_image),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(150),
                        image: DecorationImage(image: FirebaseImage('gs://tipy-98639.appspot.com/profile_pic'))
                      ),
                    ),
                    height: SizeConfig.blockSizeHorizontal * 50,
                    width: SizeConfig.blockSizeHorizontal * 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage('images/dp.png')),
                        borderRadius: BorderRadius.circular(150)
                    ),
                  ),
                  Positioned(
                    left: SizeConfig.blockSizeHorizontal * 35,
                    bottom: SizeConfig.blockSizeVertical * 1,
                    child: Container(
                      height: SizeConfig.blockSizeHorizontal * 12,
                      width: SizeConfig.blockSizeHorizontal * 12,
                      decoration: BoxDecoration(
                        boxShadow:[
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 10,

                          )
                        ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(150)
                      ),
                      child: IconButton(icon: Icon(Icons.edit),
                          onPressed: (){
                            if (Platform.isIOS){
                              showCupertinoModalPopup(
                                  context: context,
                                  builder: (BuildContext context) => CupertinoActionSheet(
                                    cancelButton: CupertinoActionSheetAction(
                                        onPressed: (){
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cancel')),
                                    actions: <Widget>[
                                      CupertinoActionSheetAction(
                                          onPressed: (){
                                            Navigator.of(context).pop();
                                            showCupertinoModalPopup(
                                                context: context,
                                                builder: (BuildContext context) =>
                                                  CupertinoActionSheet(
                                                    title: Text('This photo will be removed from your profile'),
                                                    cancelButton: CupertinoActionSheetAction(
                                                        onPressed: (){
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: Text('Cancel')),
                                                    actions: <Widget>[
                                                      CupertinoActionSheetAction(
                                                          onPressed: (){
                                                            setState(() {
                                                              _image = null;
                                                              profilePic.delete();
                                                            });
                                                            Navigator.of(context).pop();
                                                          },
                                                          child: Text('Delete Photo', style: TextStyle(color: Colors.red),))
                                                    ],
                                                  )
                                                );

                                          },
                                          child: Text('Delete Photo', style: TextStyle(color: Colors.red),)),
                                      CupertinoActionSheetAction(
                                          onPressed: (){
                                            getCameraImage();
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Take Photo')),
                                      CupertinoActionSheetAction(
                                          onPressed: (){
                                            getGalleryImage();
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Choose Photo')),
                                    ],
                                  ));
                            }
                            if(Platform.isAndroid){
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context){
                                    return Container(
                                      child: Wrap(
                                        children: <Widget>[
                                          ListTile(
                                            title: Text('Take Photo'),
                                            onTap: (){
                                              getCameraImage();
                                            },
                                          ),
                                          ListTile(
                                            title: Text('Choose Photo'),
                                            onTap: (){
                                              getGalleryImage();
                                            },
                                          ),
                                          ListTile(
                                            title: Text('Delete Photo', style: TextStyle(color: Colors.red),),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            }
                          }
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 5,),
              Text(
                  'Lmao Lolling',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'myriadpro',
                  fontSize: SizeConfig.blockSizeHorizontal * 9
                ),
              ),
              Text(
                '@username',
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'myriadpro',
                  fontSize: SizeConfig.blockSizeHorizontal * 4
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 4,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: SizeConfig.blockSizeVertical * 15,
                decoration: BoxDecoration(
                  color: Colors.green[200],
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

