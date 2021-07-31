import 'package:flutter/material.dart';
import 'package:rollbrett_rottweil/login/login_view.dart';
import 'package:rollbrett_rottweil/theme/theme_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Rollbrett Rottweil',
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        home: Login());
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final text = MediaQuery.of(context).platformBrightness == Brightness.dark
        ? "dark theme"
        : "light theme";

    return Scaffold(
      body: Center(
        child: Text(text),
      ),
    );
  }
}
