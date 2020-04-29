import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_app4/home_screen.dart';
import 'package:login_app4/sign_up_screen.dart';
import 'size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginScreen extends StatefulWidget {

  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _auth = FirebaseAuth.instance;

  String _email;
  String _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();



  bool status = true;
  Icon eye = Icon(CupertinoIcons.eye_solid, color: Colors.grey,);
  Color buttonColor = Colors.grey;
  bool buttonEnabled = false;


  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {


      if(value.isEmpty)
        return 'Email is required';
      else
        return 'Enter a valid email address';
    }
    else{


      return null;
    }
  }

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
                          'Nice To See You!',
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
                            _email = value;
                          },
                          validator: validateEmail,
                          autovalidate: true,
                          style: TextStyle(
                              fontFamily: 'myriadpro',
                            fontSize: SizeConfig.blockSizeVertical * 2
                          ),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: 'Email',
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
                          autovalidate: true,
                          validator: (password){
                      Pattern pattern =
                      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,100}$';
                      RegExp regex = new RegExp(pattern);
                      if (!regex.hasMatch(password)){
                        if(password.isEmpty)
                          return 'Password is required';
                        else
                          return 'Invalid password';
                      }
                      else
                      return null;
                      },
                          onChanged: (value){
                            _password = value;
                          },
                          style: TextStyle(
                              fontFamily: 'myriadpro',
                            fontSize: SizeConfig.blockSizeVertical * 2
                          ),
                          obscureText: status,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: eye,
                                  onPressed: (){
                                    setState(() {
                                      if (status == true){
                                        eye = Icon(CupertinoIcons.eye, color: Colors.green,);
                                        status = false;

                                      }
                                      else{
                                        eye = Icon(CupertinoIcons.eye_solid, color: Colors.grey,);
                                        status = true;

                                      }
                                    });
                                  }),
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: 'Password',
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

                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if(buttonEnabled == false){

                          }else{

                            try {

                              _scaffoldKey.currentState.showSnackBar(
                                  new SnackBar(duration: new Duration(seconds: 4), content:
                                  new Row(
                                    children: <Widget>[
                                      new CircularProgressIndicator(),
                                      new Text("  We're going in... 😉")
                                    ],
                                  ),
                                  ));

                              final user = await _auth.signInWithEmailAndPassword(
                                  email: _email, password: _password);
                              if (user != null) {
                                Navigator.pushNamed(context, HomeScreen.id);
                              }
                            }
//                            catch(e){
//                              print(e);
//
//                              _scaffoldKey.currentState.showSnackBar(
//                                  new SnackBar(duration: new Duration(seconds: 4), content:
//                                  new Row(
//                                    children: <Widget>[
//                                      Text('''We couldn't go in 😔
//Check your network or Email and Password.'''),
//                                    ],
//                                  ),
//                                  ));
//
//                            }
                            catch (e) {
                              authProblems errorType;
                              if (Platform.isAndroid) {
                                switch (e.message) {
                                  case 'Too many unsuccessful login attempts. Please try again later.':
                                    errorType = authProblems.TooManyTimes;
                                    break;
                                  case 'There is no user record corresponding to this identifier. The user may have been deleted.':
                                    errorType = authProblems.UserNotFound;
                                    break;
                                  case 'The password is invalid or the user does not have a password.':
                                    errorType = authProblems.PasswordNotValid;
                                    break;
                                  case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
                                    errorType = authProblems.NetworkError;
                                    break;
                                // ...
                                  default:
                                    print('Case ${e.message} is not yet implemented');
                                }
                              } else if (Platform.isIOS) {
                                switch (e.message) {
                                  case 'Too many unsuccessful login attempts. Please try again later.':
                                  errorType = authProblems.TooManyTimes;
                                    break;
                                  case 'There is no user record corresponding to this identifier. The user may have been deleted.':
                                    errorType = authProblems.UserNotFound;
                                    break;
                                  case 'The password is invalid or the user does not have a password.':
                                    errorType = authProblems.PasswordNotValid;
                                    break;
                                  case 'Network error (such as timeout, interrupted connection or unreachable host) has occurred.':
                                    errorType = authProblems.NetworkError;
                                    break;
                                // ...
                                  default:
                                    print('Case ${e.message} is not yet implemented');
                                }
                              }
                              if(errorType == authProblems.NetworkError){
                                _scaffoldKey.currentState.showSnackBar(
                                  new SnackBar(duration: new Duration(seconds: 4), content:
                                  new Row(
                                    children: <Widget>[
                                      Text('''We couldn't go in 😔
Check your network or Check your network''', style: TextStyle(
                                          fontFamily: 'myriadpro',
                                          fontSize: SizeConfig.blockSizeVertical * 2
                                      ),),
                                    ],
                                  ),
                                  ));
                              }
                              if(errorType == authProblems.PasswordNotValid){
                                _scaffoldKey.currentState.showSnackBar(
                                    new SnackBar(duration: new Duration(seconds: 4), content:
                                    new Row(
                                      children: <Widget>[
                                        Text('''We couldn't go in 😔
The Password doesn\'t match the Email''',
                                        style: TextStyle(
                                          fontFamily: 'myriadpro',
                                          fontSize: SizeConfig.blockSizeVertical * 2
                                        ),),
                                      ],
                                    ),
                                    ));
                              }
                              if(errorType == authProblems.UserNotFound){
                                _scaffoldKey.currentState.showSnackBar(
                                    new SnackBar(duration: new Duration(seconds: 4), content:
                                    new Row(
                                      children: <Widget>[
                                        Text('''We couldn't go in 😔
The Email doesn\'t match any account here.
Check again or Sign Up''', style: TextStyle(
                                            fontFamily: 'myriadpro',
                                            fontSize: SizeConfig.blockSizeVertical * 2
                                        ),
                                        ),
                                      ],
                                    ),
                                    ));
                              }
                              if(errorType == authProblems.TooManyTimes){
                                _scaffoldKey.currentState.showSnackBar(
                                    new SnackBar(duration: new Duration(seconds: 4), content:
                                    new Row(
                                      children: <Widget>[
                                        Text('''We couldn't go in 😔
There has been too many unsuccesful logins
Try again later''', style: TextStyle(
                                            fontFamily: 'myriadpro',
                                            fontSize: SizeConfig.blockSizeVertical * 2
                                        ),
                                        ),
                                      ],
                                    ),
                                    ));
                              }
                            }
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4),
                          height: SizeConfig.blockSizeVertical * 5,
                          width:  SizeConfig.blockSizeVertical * 13,
                          child: Material(
                            borderRadius: BorderRadius.all(Radius.circular(150)),
                            shadowColor: Colors.greenAccent,
                            color: buttonColor,
                            elevation: 7,
                            child: Center(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: SizeConfig.blockSizeVertical * 2,
                                    fontFamily: 'myriadpro'
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 27,),
                      Container(
                        margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                  fontFamily: 'myriadpro',
                                  fontSize: SizeConfig.blockSizeVertical * 2
                              ),
                            ),
                            SizedBox(width: SizeConfig.blockSizeHorizontal * 1,),
                            InkWell(
                              onTap: (){
                                Navigator.pushNamed(context, SignUpScreen.id);
                              },
                              child: Text(
                                'Sign Up.',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontFamily: 'myriadpro',
                                    fontSize: SizeConfig.blockSizeVertical * 2,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
