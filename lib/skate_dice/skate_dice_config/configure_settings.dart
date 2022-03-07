import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rollbrett_rottweil/app_localizations.dart';
import 'package:rollbrett_rottweil/reusable/custom_app_bar.dart';
import 'package:rollbrett_rottweil/skate_dice/provider/SettingProvider.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/drop_down_widget.dart';

class ConfigureSettings extends StatefulWidget {
  const ConfigureSettings({Key key}) : super(key: key);

  @override
  _ConfigureSettingsState createState() => _ConfigureSettingsState();
}

class _ConfigureSettingsState extends State<ConfigureSettings> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingsProvider>(context);
    final _allSettingHeaders = provider.settingItems;
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomAppBar(
              text: AppLocalizations.of(context).translate("settings")),
          ListView.builder(
              itemCount: _allSettingHeaders.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return DropDownWidget(_allSettingHeaders[index]);
              })
        ],
      ),
    );
  }
}
