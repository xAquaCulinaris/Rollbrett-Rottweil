import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rollbrett_rottweil/app_localizations.dart';
import 'package:rollbrett_rottweil/reusable/custom_app_bar.dart';
import 'package:rollbrett_rottweil/skate_dice/provider/SettingProvider.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/radiobutton_item.dart';

class ConfigureSettings extends StatefulWidget {
  const ConfigureSettings({Key key}) : super(key: key);

  @override
  _ConfigureSettingsState createState() => _ConfigureSettingsState();
}

class _ConfigureSettingsState extends State<ConfigureSettings> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingsProvider>(context);
    return Column(children: [
      CustomAppBar(text: AppLocalizations.of(context).translate("settings")),
      CustomRadioButtonHeader("Show Stance", ["Yes", "No"], () {
        return provider.getStance();
      }, (value) {
        provider.setStance(value);
      })
    ]);
  }
}
