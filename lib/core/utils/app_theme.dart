
import 'package:flutter/material.dart';

class MyAppTheme{

  static ThemeData lightTheme(){
    return ThemeData(
      colorScheme: const ColorScheme(
        primary: Color(0xFFFE3C5B),
        secondary: Color(0xFFe84545),
        background: Color(0xFFFFFFFF),
        surface: Color(0xFFFFFFFF),
        error: Color(0x00000000),
        brightness: Brightness.light,
        onPrimary: Color(0xFFFFFFFF),
        onSecondary: Color(0xFFFFFFFF),
        onError: Color(0xFF2b2e4a),
        onBackground: Color(0xFF2b2e4a),
        onSurface: Color(0xFF2b2e4a),
      ),
    );
  }

  static ThemeData darkTheme(){
    return ThemeData(
      primarySwatch: Colors.teal,
      //brightness: Brightness.dark,
      //scaffoldBackgroundColor: Colors.black,
      colorScheme: const ColorScheme(

        primary: Color(0xFFFE3C5B),
        secondary: Color(0xFFe88887),
        background: Colors.black,

        surface:Color(0xFFFE3C5B),
        error: Color(0x00000000),
        brightness: Brightness.dark,
        onPrimary: Colors.black,
        onSecondary: Color(0xFFFFFFFF),
        onError: Color(0xFF2b2e4a),
        onBackground: Colors.teal,
        onSurface: Colors.white,
      ),
    );
  }
}