import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rollbrett_rottweil/skate_dice/models/ItemHeader.dart';
import 'package:rollbrett_rottweil/skate_dice/models/SettingsItem.dart';

class SettingsProvider with ChangeNotifier {
  List<ItemHeader> _items = [];

  SettingsProvider() {
    loadSettings().then((items) {
      _items = items;
      notifyListeners();
    });
  }

  List<ItemHeader> get items => _items;

  Difficulty getDifficulty() {
    //Find the difficulty item header
    ItemHeader itemHeader = _getItemHeadByName("Difficulty");
    //Loop over all subitems
    for (SettingItem settingItem in itemHeader.items) {
      //If one is found that is checked return the difficulty
      if (settingItem.checked) return _calculateDifficulty(settingItem.name);
    }
    return null;
  }

  bool getTrickIntoGrind() {
    ItemHeader itemHeader = _getItemHeadByName("Tricks into Grinds");

    if (itemHeader.items[0].checked) return true;
    return false;
  }

  bool getShowStance() {
    ItemHeader itemHeader = _getItemHeadByName("Show stance");

    if (itemHeader.items[0].checked) return true;
    return false;
  }

  bool getShowDirections() {
    ItemHeader itemHeader = _getItemHeadByName("Show directions");

    if (itemHeader.items[0].checked) return true;
    return false;
  }

  Difficulty _calculateDifficulty(String name) {
    switch (name) {
      case "Easy":
        return Difficulty.Easy;
        break;
      case "Medium":
        return Difficulty.Medium;
        break;
      case "Hard":
        return Difficulty.Hard;
        break;
    }
    return null;
  }

  Future loadSettings() async {
    String data =
        await rootBundle.loadString("assets/skate_dice/settings.json");
    final jsonResult = json.decode(data);
    return jsonResult
        .map<ItemHeader>(
            (settingsHeader) => ItemHeader.fromJson(settingsHeader))
        .toList();
  }

  ItemHeader _getItemHeadByName(String name) {
    for (ItemHeader itemHeader in _items) {
      if (itemHeader.name == name) return itemHeader;
    }
    return null;
  }
}

enum Difficulty { Hard, Medium, Easy }
