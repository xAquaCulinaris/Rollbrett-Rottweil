import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rollbrett_rottweil/reusable/custom_app_bar.dart';
import 'package:rollbrett_rottweil/skate_dice/models/ItemHeader.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/providers/TrickProvider.dart';

import '../widgets/checkbox_list_item.dart';

class ConfigureTricks extends StatefulWidget {
  const ConfigureTricks({Key key}) : super(key: key);

  @override
  _ConfigureTricksState createState() => _ConfigureTricksState();
}

class _ConfigureTricksState extends State<ConfigureTricks> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TrickProvider>(context);
    final _allTrickHeaders = provider.items;

    return SingleChildScrollView(
      child: Column(
        children: [
          CustomAppBar(text: "Tricks"),
          ListView(
            padding: EdgeInsets.all(0),
            shrinkWrap: true,
            children: _allTrickHeaders.map((obstacleHeader) {
              int _index = _allTrickHeaders.indexOf(obstacleHeader);
              return CustomCheckboxHeader(
                updateFunction: updateChecks,
                headerIndex: _index,
                allObstacleHeaders: _allTrickHeaders,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void updateChecks(List<ItemHeader> _allObstacleHeaders, int headerIndex,
      int obstacleIndex) {
    if (mounted)
      setState(() {
        _allObstacleHeaders[headerIndex].items[obstacleIndex].checked =
            !_allObstacleHeaders[headerIndex].items[obstacleIndex].checked;
      });
  }
}
