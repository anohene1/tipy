import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


enum TipyThemeKeys {light, dark}

class TipyTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.green,
    accentColor: Colors.greenAccent,
    brightness: Brightness.light,
    iconTheme: IconThemeData(
      color: Colors.black
    ),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(
          color: Colors.black
      ),
    ),
    cursorColor: Colors.green
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: Colors.green,
    brightness: Brightness.dark,
    accentColor: Colors.greenAccent,
    iconTheme: IconThemeData(
      color: Colors.white
    ),
    appBarTheme: AppBarTheme(
      color: Colors.grey[800],
          iconTheme: IconThemeData(
        color: Colors.white
    )
    ),
    cursorColor: Colors.green
  );

  static ThemeData getThemeFromKey(TipyThemeKeys themeKey){
    switch (themeKey){
      case TipyThemeKeys.light:
        return lightTheme;
      case TipyThemeKeys.dark:
        return darkTheme;
      default:
        return lightTheme;
    }
  }
}


