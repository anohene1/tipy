import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_app4/login_screen.dart';
import 'package:login_app4/home_screen.dart';
import 'package:login_app4/my_posts_screen.dart';
import 'package:login_app4/my_replies_screen.dart';
import 'package:login_app4/profile_screen.dart';
import 'package:login_app4/sign_up_screen.dart';
import 'package:login_app4/welcome_screen.dart';
import 'package:animated_splash/animated_splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'dart:math';
import 'package:login/login.dart';
import 'package:login_app4/world_screen.dart';
import 'package:theme_provider/theme_provider.dart';






void main() async => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green,
        accentColor: Colors.greenAccent,
        fontFamily: 'myriadpro'
      ),
      home: AnimatedSplash(
          imagePath: 'images/logos.gif',
          home: Login(
            loggedIn: HomeScreen(),
            loggedOut: WelcomeScreen(),
          ),
        duration: 2500,
        type: AnimatedSplashType.StaticDuration,
      ),
      routes: {
        LoginScreen.id : (context) => LoginScreen(),
        SignUpScreen.id : (context) => SignUpScreen(),
        WelcomeScreen.id : (context) => WelcomeScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        WorldScreen.id: (context) => WorldScreen(),
        MyPostsScreen.id: (context) => MyPostsScreen(),
        MyRepliesScreen.id: (context) => MyRepliesScreen()
      },
    );
  }
}

