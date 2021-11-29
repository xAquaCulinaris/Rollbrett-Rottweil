import 'package:flutter/material.dart';
import 'package:rollbrett_rottweil/app_localizations.dart';
import 'package:rollbrett_rottweil/reusable/custom_app_bar.dart';

class ConfigureSettings extends StatefulWidget {
  const ConfigureSettings({Key key}) : super(key: key);

  @override
  _ConfigureSettingsState createState() => _ConfigureSettingsState();
}

class _ConfigureSettingsState extends State<ConfigureSettings> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CustomAppBar(text: AppLocalizations.of(context).translate("settings")),
      Center(child: Text("Configure Settings"))
    ]);
  }
}
