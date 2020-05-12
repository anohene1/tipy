import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_app4/home_screen.dart';
import 'package:login_app4/login_screen.dart';
import 'size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:firebase_database/firebase_database.dart';
import 'welcome_screen.dart' as welcomeScreen;

final _firebaseDB = FirebaseDatabase.instance;
final newCustomer = _firebaseDB.reference().child('Customers available');
final customer = newCustomer.child(userID);
final geofire = customer.child('Geofire');
final userLocation = customer.child('Location');
var userID;


class SignUpScreen extends StatefulWidget {


  static const String id = 'sign_up_screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  List upperCase = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
  Pattern upperCasePattern = '([A-Z])\w+';

  String validateEmail(String value){
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {


      return 'Enter a valid email';
    }
    else{


      return null;
    }
  }

  final _auth = FirebaseAuth.instance;

  String _email;
  String _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  ProgressDialog pr;


  bool status = true;
  Icon eye = Icon(CupertinoIcons.eye_solid, color: Colors.grey,);
  Color check = Colors.grey;
  Color button = Colors.green;
  Color check8 = Colors.grey;
  Color checkUpper = Colors.grey;
  Color check1 = Colors.grey;
  bool buttonEnabled = false;
  Color buttonColor = Colors.grey;



  @override
  Widget build(BuildContext context) {

    pr = ProgressDialog(context);

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
                      Padding(
                        padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 12, left: SizeConfig.blockSizeHorizontal * 4, right: SizeConfig.blockSizeHorizontal * 4),
                        child: Text(
                          'Join Us!',
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeVertical * 5,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'myriadpro'
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 5,),
                      Container(
                        height: SizeConfig.blockSizeVertical * 8,
                        margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4, right: SizeConfig.blockSizeHorizontal * 4),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: validateEmail,
                          onChanged: (value){
                              _email = value;
                          },
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
                                  borderRadius: BorderRadius.all(Radius.circular(150))
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
                          controller: _pass,

                          onChanged: (value){
                            _password = value;
                            setState(() {
                              if(_password.length >= 8){
                                check8 = Colors.green;
                              }else{
                                check8 = Colors.grey;
                              }
                              if(_password.contains(new RegExp(r'[A-Z]'))){
                                checkUpper = Colors.green;
                              }else{
                                checkUpper = Colors.grey;
                              }
                              if(_password.contains(new RegExp(r'[0-9]'))){
                                check1 = Colors.green;
                              }else{
                                check1 = Colors.grey;
                              }
                            });
                          },
                          validator: (password){
                            Pattern pattern =
                                r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,100}$';
                            RegExp regex = new RegExp(pattern);
                            if (!regex.hasMatch(password))
                              if(password.isEmpty) {
                                return 'Password is required';
                              }else{
                                return 'Invalid password';
                              }
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
                                  borderRadius: BorderRadius.all(Radius.circular(150))
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
                          controller: _confirmPass,
                          validator: (val){
                            if(val.isEmpty)
                              return 'Password required';
                            if(val != _pass.text)
                              return 'Passwords do not match';
                            return null;
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
                              hintText: 'Confirm Password',
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey[200]),
                                  borderRadius: BorderRadius.all(Radius.circular(150))
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
                        margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4),
                        child: Text(
                          'Password should be',
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeVertical * 2,
                              fontFamily: 'myriadpro'
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 1,),
                      Container(
                        margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4, right: SizeConfig.blockSizeHorizontal * 4),
                        child: Row(
                          children: <Widget>[
                            Icon(CupertinoIcons.check_mark_circled_solid, color: check8, size: SizeConfig.blockSizeVertical * 2.5,),
                            SizedBox(width: 2,),
                            Text('At least 8 characters',
                              style: TextStyle(
                                  fontFamily: 'myriadpro',
                                  fontSize: SizeConfig.blockSizeVertical * 2,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 1,),
                      Container(
                        margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4, right: SizeConfig.blockSizeHorizontal * 4),
                        child: Row(
                          children: <Widget>[
                            Icon(CupertinoIcons.check_mark_circled_solid, color: checkUpper, size: SizeConfig.blockSizeVertical * 2.5,),
                            SizedBox(width: 2,),
                            Text('Minimum one uppercase',
                              style: TextStyle(
                                  fontFamily: 'myriadpro',
                                  fontSize: SizeConfig.blockSizeVertical * 2,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 1,),
                      Container(
                        margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4, right: SizeConfig.blockSizeHorizontal * 4),
                        child: Row(
                          children: <Widget>[
                            Icon(CupertinoIcons.check_mark_circled_solid, color: check1, size: SizeConfig.blockSizeVertical * 2.5,),
                            SizedBox(width: 2,),
                            Text('Minimum one number',
                              style: TextStyle(
                                  fontFamily: 'myriadpro',
                                  fontSize: SizeConfig.blockSizeVertical * 2,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 4,
                      ),
                      GestureDetector(
                        onTap: () async {
//                          print(_email);
//                          print(_password);
                        if(buttonEnabled == false){

                        }else{
                          try {

                            _scaffoldKey.currentState.showSnackBar(
                                new SnackBar(duration: new Duration(seconds: 4), content:
                                new Row(
                                  children: <Widget>[
                                    new CircularProgressIndicator(),
                                    new Text("  Getting you on board... 😁")
                                  ],
                                ),
                                ));




                            final newuser = await _auth
                                .createUserWithEmailAndPassword(
                                email: _email, password: _password);

                            if(newuser != null){
                              Navigator.pushNamed(context, HomeScreen.id);

                              userID = newuser.user.uid;
                              customer.push().set({
                                'Geofire': null,
                                'Location': null,
                                'Posts': null
                              });
                              geofire.push().set({
                                'l': 'JKJsdjsa',
                                'g': 'sjkdjskd'
                              });
                              userLocation.push().set({
                                'l': welcomeScreen.latitude,
                                'g': welcomeScreen.longitude
                              });
                            }


                          }
                          catch (e){
                            print(e);

                            _scaffoldKey.currentState.showSnackBar(
                                new SnackBar(duration: new Duration(seconds: 4), content:
                                new Row(
                                  children: <Widget>[
                                    new Text('''Aww there was a problem. 🙁
Check your network.''')
                                  ],
                                ),
                                ));

                          }
                        }
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4),
                          height: SizeConfig.blockSizeVertical * 5,
                          width: SizeConfig.blockSizeVertical * 13,
                          child: Material(
                            borderRadius: BorderRadius.all(Radius.circular(150)),
                            shadowColor: Colors.greenAccent,
                            color: buttonColor,
                            elevation: 7,
                            child: Center(
                              child: Text(
                                'Sign Up',
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
                      SizedBox(height: SizeConfig.blockSizeVertical * 8),
                      Container(
                        margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Already have an account?',
                              style: TextStyle(
                                  fontFamily: 'myriadpro',
                                  fontSize: SizeConfig.blockSizeVertical * 2,
                              ),
                            ),
                            SizedBox(width: SizeConfig.blockSizeHorizontal * 1,),
                            InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Login.',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}