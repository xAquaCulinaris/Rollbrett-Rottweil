import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rollbrett_rottweil/skate_dice/models/Item.dart';

class ObstacleProvider with ChangeNotifier {
  List<ItemHeader> _items = [];

  ObstacleProvider() {
    loadObstacles().then((items) {
      _items = items;
      notifyListeners();
    });
  }

  List<ItemHeader> get items => _items;

  List<Item> getSelectedObstacles() {
    List<Item> _selectedObstacles = [];
    for (ItemHeader header in _items) {
      _selectedObstacles.addAll(
          header.items.where((element) => element.checked).toList());
    }
    return _selectedObstacles;
  }

  Future loadObstacles() async {
    String data =
        await rootBundle.loadString("assets/skate_dice/obstacles.json");
    final jsonResult = json.decode(data);
    return jsonResult
        .map<ItemHeader>(
            (obstacleHeader) => ItemHeader.fromJson(obstacleHeader))
        .toList();
  }
}
