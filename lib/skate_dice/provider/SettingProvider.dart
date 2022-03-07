import 'package:flutter/material.dart';
import 'package:rollbrett_rottweil/skate_dice/models/EnumSettingItem/EnumItem.dart';
import 'package:rollbrett_rottweil/skate_dice/models/EnumSettingItem/EnumItemHeader.dart';

class SettingsProvider with ChangeNotifier {
  List<EnumItemHeader> _settingItems = [];

  SettingsProvider() {
    EnumItem easy = EnumItem("Easy", true);
    EnumItem medium = EnumItem("Medium", false);
    EnumItem hard = EnumItem("Hard", false);
    List<EnumItem> difficultyItems = [easy, medium, hard];
    //EnumItemHeader difficultyHeader = EnumItemHeader("Difficulty", difficultyItems);
    EnumItemHeader difficultyHeader = EnumItemHeader("Difficulty", difficultyItems);
    _settingItems.add(difficultyHeader);
  }

  List<EnumItemHeader> get settingItems => _settingItems;
}

enum Difficulty { Hard, Medium, Easy }
