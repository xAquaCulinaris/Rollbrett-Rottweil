import 'package:flutter/material.dart';

class MyThemes {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.black,
    accentColor: Colors.white70,
    colorScheme: ColorScheme.dark(),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(primary: Colors.white70, shape: StadiumBorder()))
  );

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    accentColor: Colors.black45,
    colorScheme: ColorScheme.light(),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(primary: Colors.black45, shape: StadiumBorder()))
  );
}
