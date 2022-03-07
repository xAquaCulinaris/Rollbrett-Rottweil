//The group of an item (for ex. Ledge or Difficulty)
import 'package:rollbrett_rottweil/skate_dice/models/ItemInterface.dart';
import 'package:rollbrett_rottweil/skate_dice/models/SettingsItem.dart';
import 'package:rollbrett_rottweil/skate_dice/models/TrickObstacleItem.dart';

class ItemHeader {
  final String name;
  bool expanded = false;
  final List<ItemInterface> items;

  ItemHeader(this.name, this.items);
  

  factory ItemHeader.fromJson(Map<String, dynamic> json) {
    List<ItemInterface> itemList = [];
    for (var item in json['items']) {
      String name = item['name'];
      String obstacleType = item['obstacleType'];
      bool directional = item['directional'].toString().parseBool();

      // If obstacle type is not set create a settings item
      if (obstacleType == null)
        itemList.add(SettingItem(name, directional));
      //else create a Trick/Obstacle Item
      else
        itemList.add(TrickObstacleItem(name, obstacleType, directional));
    }
    return ItemHeader(json['name'], itemList);
  }
}


extension BoolParsing on String {
  bool parseBool() {
    if (this.toLowerCase() == 'true') {
      return true;
    } else if (this.toLowerCase() == 'false') {
      return false;
    }
    return null;
  }
}
