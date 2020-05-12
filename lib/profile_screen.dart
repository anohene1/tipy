import 'package:login_app4/home_screen.dart';
import 'package:login_app4/size_config.dart';

import 'main.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class ProfileScreen extends StatefulWidget {


  static const id = 'profile_screen';




  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}



class _ProfileScreenState extends State<ProfileScreen> {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(image: AssetImage('images/logo.png')),
                  borderRadius: BorderRadius.circular(150)
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Email: ',
                    style: TextStyle(
                      fontFamily: 'myriadpro',
                      fontSize: SizeConfig.blockSizeVertical * 2
                    ),
                  ),
                  Text(
                    'lmao@gmail.com',
                    style: TextStyle(
                        fontFamily: 'myriadpro',
                        fontSize: SizeConfig.blockSizeVertical * 2
                    ),
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 3,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Username: ',
                    style: TextStyle(
                        fontFamily: 'myriadpro',
                        fontSize: SizeConfig.blockSizeVertical * 2
                    ),
                  ),
                  Text(
                    'lmao',
                    style: TextStyle(
                        fontFamily: 'myriadpro',
                        fontSize: SizeConfig.blockSizeVertical * 2
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
