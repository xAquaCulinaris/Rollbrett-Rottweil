import 'package:flutter/material.dart';
import 'package:rollbrett_rottweil/reusable/custom_app_bar.dart';

class ConfigureTricks extends StatefulWidget {
  const ConfigureTricks({Key key}) : super(key: key);

  @override
  _ConfigureTricksState createState() => _ConfigureTricksState();
}

class _ConfigureTricksState extends State<ConfigureTricks> {
  @override
  Widget build(BuildContext context) {
   return Column(children: [
      CustomAppBar(text: "Tricks"),
      Center(child: Text("Configure Tricks"))
    ]);
  }
}