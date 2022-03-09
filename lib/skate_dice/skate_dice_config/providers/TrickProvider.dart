import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rollbrett_rottweil/skate_dice/models/ItemInterface.dart';
import 'package:rollbrett_rottweil/skate_dice/models/TrickObstacleItem.dart';
import 'package:rollbrett_rottweil/skate_dice/models/ItemHeader.dart';

class TrickProvider with ChangeNotifier {
  List<ItemHeader> _items = [];

  TrickProvider() {
    loadTricks().then((items) {
      _items = items;
      notifyListeners();
    });
  }

  List<ItemHeader> get items => _items;

  List<TrickObstacleItem> getSelectedTricks() {
    List<ItemInterface> _selectedTricks = [];
    for (ItemHeader header in _items) {
      _selectedTricks.addAll(
          header.items.where((element) => element.checked).toList());
    }
    return _selectedTricks.cast<TrickObstacleItem>();
  }

   List<TrickObstacleItem> getTrickByDifficultyAndType(ExtendedDifficulty difficulty, ObstacleType obstacleType) {
    List<ItemInterface> _selectedTricks = [];
    for (ItemHeader header in _items) {
      _selectedTricks.addAll(
          header.items.where((element) => element.checked && element.difficulty == difficulty).toList());
    }
    List<TrickObstacleItem> list = _selectedTricks.cast<TrickObstacleItem>();
    return list.where((element) => element.obstacleType == obstacleType).toList();
  }

  Future loadTricks() async {
    String data =
        await rootBundle.loadString("assets/skate_dice/tricks.json");
    final jsonResult = json.decode(data);
    return jsonResult
        .map<ItemHeader>(
            (itemHeader) => ItemHeader.fromJson(itemHeader))
        .toList();
  }
}
