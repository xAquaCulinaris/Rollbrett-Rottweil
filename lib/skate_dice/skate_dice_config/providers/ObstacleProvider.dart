import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rollbrett_rottweil/skate_dice/models/ItemInterface.dart';
import 'package:rollbrett_rottweil/skate_dice/models/TrickObstacleItem.dart';
import 'package:rollbrett_rottweil/skate_dice/models/ItemHeader.dart';

class SkateDiceObstacleProvider with ChangeNotifier {
  List<ItemHeader> _items = [];

  SkateDiceObstacleProvider() {
    if (_items == null || _items.length == 0) loadObstacles();
  }

  void loadObstacles() {
    _loadObstacles().then((items) {
      _items = items;
      notifyListeners();
      print("loaded obstacles");
    });
  }

  List<ItemHeader> get items => _items;

  List<TrickObstacleItem> getObstaclesByDifficulty(
      ExtendedDifficulty difficulty) {
    List<ItemInterface> _selectedObstacles = [];
    for (ItemHeader header in _items) {
      _selectedObstacles.addAll(header.items
          .where(
              (element) => element.checked && element.difficulty == difficulty)
          .toList());
    }
    return _selectedObstacles.cast<TrickObstacleItem>();
  }

  String getObstacleLinkNameByName(String name) {
    for (ItemHeader header in _items) {
      for (var obstacle in header.items) {
        if (obstacle.name == name) return obstacle.obstacleLink;
      }
    }
  }

  Future _loadObstacles() async {
    String data =
        await rootBundle.loadString("assets/skate_dice/obstacles.json");
    final jsonResult = json.decode(data);
    return jsonResult
        .map<ItemHeader>(
            (obstacleHeader) => ItemHeader.fromJson(obstacleHeader))
        .toList();
  }
}
