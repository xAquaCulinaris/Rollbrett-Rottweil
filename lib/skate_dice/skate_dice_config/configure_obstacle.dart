import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rollbrett_rottweil/reusable/custom_app_bar.dart';
import 'package:rollbrett_rottweil/skate_dice/provider/ObstacleProvider.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/checkbox_item.dart';

class ConfigureObstacles extends StatefulWidget {
  const ConfigureObstacles({Key key}) : super(key: key);

  @override
  _ConfigureObstaclesState createState() => _ConfigureObstaclesState();
}

class _ConfigureObstaclesState extends State<ConfigureObstacles> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ObstacleProvider>(context);
    final _allObstacleHeaders = provider.items;

//TODO add scrolling (column sucks)
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomAppBar(text: "Obstacles"),
          ListView(
            padding: EdgeInsets.all(0),
            shrinkWrap: true,
            children: _allObstacleHeaders.map((obstacleHeader) {
              int _index = _allObstacleHeaders.indexOf(obstacleHeader);
              return CustomCheckboxHeader(
                headerIndex: _index,
                provider: provider,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
