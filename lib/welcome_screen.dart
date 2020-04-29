import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_app4/login_screen.dart';
import 'package:login_app4/sign_up_screen.dart';
import 'package:login_app4/size_config.dart';
import 'location.dart';

class WelcomeScreen extends StatelessWidget {

  static const id = 'welcome_screen';

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);

    return MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  double latitude;
  double longitude;

  void getLocation() async{
    Locations location = Locations();
    await location.getCurrentLocation();
    longitude = location.longitude;
    latitude = location.latitude;
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.green,
            accentColor: Colors.greenAccent,
            fontFamily: 'myriadpro'
        ),
        home: Scaffold(
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: SizeConfig.blockSizeVertical * 20,
                      width: SizeConfig.blockSizeHorizontal * 80,
                      margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4),
                      child: Padding(
                        padding: EdgeInsets.only(top: SizeConfig.screenHeight / 7),
                        child: Text(
                          'Get Connected!',
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeVertical * 5,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'myriadpro'
                          ),
                        ),
                      ),
                    ),
//                    SizedBox(height: 10,),
                    Container(
                      margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4),
                      child: Text(
                        'to the world\'s first true Global Village.',
                        style: TextStyle(
                            fontFamily: 'myriadpro',
                            fontSize: SizeConfig.blockSizeVertical * 2
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 5,),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      child: Container(
                        height: SizeConfig.blockSizeVertical * 5,
                        width: SizeConfig.blockSizeVertical * 13,
                        margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4, right: SizeConfig.blockSizeHorizontal * 4),
                        child: Container(
                          height: SizeConfig.blockSizeVertical * 5,
                          width: SizeConfig.blockSizeVertical * 13,
                          child: Material(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            shadowColor: Colors.greenAccent,
                            color: Colors.green,
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
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 1,),
                    Center(
                      child: Container(
                        height: SizeConfig.blockSizeVertical * 50,
                        width: SizeConfig.blockSizeVertical * 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage('images/introo.png'), fit: BoxFit.cover)
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 5,),
                    Container(
                      margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4, right: SizeConfig.blockSizeHorizontal * 4),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Are you new here?',
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 2,
                                fontFamily: 'myriadpro'
                            ),
                          ),
                          SizedBox(width: SizeConfig.blockSizeHorizontal * 1,),
                          InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, SignUpScreen.id);
                            },
                            child: Text(
                              'Register.',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                  fontSize: SizeConfig.blockSizeVertical * 2
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
//                SizedBox(height: SizeConfig.blockSizeVertical * 2,)
              ],
            ),
          ),
        )
    );
  }
}