import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rollbrett_rottweil/app_localizations.dart';
import 'package:rollbrett_rottweil/course_preview/provider/obstacleProvider.dart';
import 'package:rollbrett_rottweil/home_page.dart';
import 'package:rollbrett_rottweil/login/login_view.dart';
import 'package:rollbrett_rottweil/skate_dice/models/Player.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/providers/ObstacleProvider.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/providers/SettingProvider.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/providers/TrickProvider.dart';
import 'package:rollbrett_rottweil/theme/theme_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<PlayerList>(create: (_) => PlayerList()),
        ListenableProvider<SettingsProvider>(create: (_) => SettingsProvider()),
        ListenableProvider<SkateDiceObstacleProvider>(create: (_) => SkateDiceObstacleProvider()),
        ListenableProvider<TrickProvider>(create: (_) => TrickProvider()),
        ListenableProvider<SettingsProvider>(create: (_) => SettingsProvider()),
        ListenableProvider<CoursePreviewObstaclesProvider>(create: (_) => CoursePreviewObstaclesProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
        //TODO add check if logged in or not
        home: Login(),
        // home: HomePage(),
      ),
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
