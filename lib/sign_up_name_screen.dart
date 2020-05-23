import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_app4/home_screen.dart';
import 'package:login_app4/sign_up_screen.dart';
import 'size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';


final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
final profileRef = _firebaseDatabase.reference().child('Profile');

class SignUpNameScreen extends StatefulWidget {

  static const String id = 'sign_up_name_screen';


  @override
  _SignUpNameScreenState createState() => _SignUpNameScreenState();
}

class _SignUpNameScreenState extends State<SignUpNameScreen> {

  final _auth = FirebaseAuth.instance;

  String name;
  String username;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();




  bool status = true;
  Icon eye = Icon(CupertinoIcons.eye_solid, color: Colors.grey,);
  Color buttonColor = Colors.grey;
  bool buttonEnabled = false;



  @override
  Widget build(BuildContext context) {



    SizeConfig().init(context);
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.green,
          accentColor: Colors.greenAccent,
          fontFamily: 'myriadpro'
      ),
      home: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Form(
                  key: _formKey,
                  onChanged: (){
                    setState(() {
                      buttonEnabled = _formKey.currentState.validate();

                      if(buttonEnabled == true){
                        buttonColor = Colors.green;
                        buttonEnabled = true;
                      }
                      else{
                        buttonColor = Colors.grey;
                        buttonEnabled = false;
                      }
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.green, size: SizeConfig.blockSizeVertical * 4,),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      SizedBox(height: SizeConfig.blockSizeVertical * 9,),
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 20, left: SizeConfig.blockSizeHorizontal * 4),
                        child: Text(
                          "We're Almost There!",
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeVertical * 5,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'myriadpro'
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 5,),
                      Container(
                        margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4, right: SizeConfig.blockSizeHorizontal * 4),
                        height: SizeConfig.blockSizeVertical * 8,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value){
                            name = value;
                          },
                          style: TextStyle(
                              fontFamily: 'myriadpro',
                              fontSize: SizeConfig.blockSizeVertical * 2
                          ),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: 'Name',
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey[200]),
                                borderRadius: BorderRadius.all(Radius.circular(150)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey[200]),
                                  borderRadius: BorderRadius.all(Radius.circular(150))
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green),
                                  borderRadius: BorderRadius.all(Radius.circular(150))
                              )
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                      Container(
                        height: SizeConfig.blockSizeVertical * 8,
                        margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4, right: SizeConfig.blockSizeHorizontal * 4),
                        child: TextFormField(
                          onChanged: (value){
                            username = value;
                          },
                          style: TextStyle(
                              fontFamily: 'myriadpro',
                              fontSize: SizeConfig.blockSizeVertical * 2
                          ),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: 'Username',
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey[200]),
                                borderRadius: BorderRadius.all(Radius.circular(150)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey[200]),
                                  borderRadius: BorderRadius.all(Radius.circular(150))
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green),
                                  borderRadius: BorderRadius.all(Radius.circular(150))
                              )
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 3,),

                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4),
                          height: SizeConfig.blockSizeVertical * 5,
                          width:  SizeConfig.blockSizeVertical * 13,
                          child: Material(
                            borderRadius: BorderRadius.all(Radius.circular(150)),
                            color: Colors.green,
                            shadowColor: Colors.greenAccent,
                            elevation: 7,
                            child: Center(
                              child: Text(
                                'Finish',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: SizeConfig.blockSizeVertical * 2,
                                    fontFamily: 'myriadpro'
                                ),
                              ),
                            ),
                          ),
                        ),
                        onTap: (){
                          profileRef.push().set({
                            'name': name,
                            'username': '@$username'
                          });
                          Navigator.pushNamed(context, HomeScreen.id);
                        },
                      )
                    ],
                  ),
                ),
//              SizedBox(height: SizeConfig.blockSizeVertical * 1,)
              ],
            ),
          ),
        ),
      ),
    );

  }

}

enum authProblems { UserNotFound, PasswordNotValid, NetworkError, TooManyTimes }
