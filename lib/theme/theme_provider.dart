import 'package:flutter/material.dart';

class MyThemes {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.black,
    accentColor: Colors.grey[400],
    colorScheme: ColorScheme.dark(),
    
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(primary: Colors.grey[400], shape: StadiumBorder()))
  );

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Roboto',
    primaryColor: Colors.white,
    accentColor: Colors.grey[700],
    colorScheme: ColorScheme.light(),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(primary: Colors.grey[700], shape: StadiumBorder()))
  );
}
