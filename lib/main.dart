import 'package:flutter/material.dart';
import 'package:rollbrett_rottweil/app_localizations.dart';
import 'package:rollbrett_rottweil/login/login_view.dart';
import 'package:rollbrett_rottweil/theme/theme_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
      supportedLocales: [Locale('en'), Locale('de')],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeListResolutionCallback: (locale, supportedLocales) {
        var retLocale = supportedLocales.first;
        // Check if the current device locale is supported
        if (locale != null) {
          print ("user locale ${locale.first.languageCode}, ${locale.first.countryCode}");
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.first.languageCode) {
              retLocale = supportedLocale;
              if (supportedLocale.countryCode == locale.first.countryCode) {
                break;
              }
            }
          }
        }


        return retLocale;
      },
      home: Login(),
    );
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
