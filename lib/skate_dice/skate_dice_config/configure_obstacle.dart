import 'package:flutter/material.dart';
import 'package:rollbrett_rottweil/reusable/custom_app_bar.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/checkbox_list_item.dart';

class ConfigureObstacles extends StatefulWidget {
  const ConfigureObstacles({Key key}) : super(key: key);

  @override
  _ConfigureObstaclesState createState() => _ConfigureObstaclesState();
}

class _ConfigureObstaclesState extends State<ConfigureObstacles> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CustomAppBar(text: "Obstacles"),
      Expanded(
        child: CustomCheckboxHeader(
          name: "Ledges",
          items: [
            CustomCheckboxListItem("Mannypad", false),
            CustomCheckboxListItem("Hubba", false),
            CustomCheckboxListItem("Brunnen", false)
          ],
        ),
      )
    ]);
  }
}
