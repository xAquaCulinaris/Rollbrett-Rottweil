import 'package:rollbrett_rottweil/skate_dice/models/ItemInterface.dart';

class SettingItem extends ItemInterface {
  SettingItem(String name, bool directional) {
    this.name = name;
    this.directional = directional;
  }
}
