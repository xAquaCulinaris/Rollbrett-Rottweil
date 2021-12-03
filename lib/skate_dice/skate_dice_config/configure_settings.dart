import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rollbrett_rottweil/app_localizations.dart';
import 'package:rollbrett_rottweil/reusable/custom_app_bar.dart';
import 'package:rollbrett_rottweil/skate_dice/models/ItemHeader.dart';
import 'package:rollbrett_rottweil/skate_dice/provider/SettingProvider.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/checkbox_list_item.dart';

class ConfigureSettings extends StatefulWidget {
  const ConfigureSettings({Key key}) : super(key: key);

  @override
  _ConfigureSettingsState createState() => _ConfigureSettingsState();
}

class _ConfigureSettingsState extends State<ConfigureSettings> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingsProvider>(context);
    final _allSettingHeaders = provider.items;
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomAppBar(
              text: AppLocalizations.of(context).translate("settings")),
          ListView.builder(
              itemCount: _allSettingHeaders.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CustomCheckboxHeader(
                    headerIndex: index,
                    allObstacleHeaders: _allSettingHeaders,
                    updateFunction: updateChecks,
                    selectOnlyOne: true);
              })
        ],
      ),
    );
  }

  void updateChecks(List<ItemHeader> _allObstacleHeaders, int headerIndex,
      int obstacleIndex) {
    for (int i = 0; i < _allObstacleHeaders[headerIndex].items.length; i++) {
      if (mounted)
        setState(() {
          _allObstacleHeaders[headerIndex].items[i].checked = false;
        });
    }
    if (mounted)
      setState(() {
        _allObstacleHeaders[headerIndex].items[obstacleIndex].checked = true;
      });
    print("called");
  }
}
