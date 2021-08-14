import 'package:flutter/material.dart';

class MyThemes {
  static final darkTheme = ThemeData(
    fontFamily: 'Roboto',
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.black,
    primaryColorBrightness: Brightness.dark,
    primarySwatch: Colors.grey,
    accentColor: Colors.grey[400],
    accentColorBrightness: Brightness.dark,
    colorScheme: ColorScheme.dark(),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(primary: Colors.grey[400], shape: StadiumBorder())),
    textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.grey[500], selectionColor: Colors.grey[500])
  );

  static final lightTheme = ThemeData(
    fontFamily: 'Roboto',
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    primaryColorBrightness: Brightness.light,
    primarySwatch: Colors.grey,
    accentColor: Colors.grey[850],
    accentColorBrightness: Brightness.light,
    colorScheme: ColorScheme.light(),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(primary: Colors.grey[850], shape: StadiumBorder())),
    textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.grey[950], selectionColor: Colors.grey[950])
  );
}
