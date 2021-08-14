import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rollbrett_rottweil/skate_dice/models/Obstacle.dart';

class ObstacleProvider with ChangeNotifier {
  List<ObstacleHeader> _obstacles = [];

  ObstacleProvider() {
    loadObstacles().then((obstacles) {
      _obstacles = obstacles;
      notifyListeners();
    });
  }

  List<ObstacleHeader> get obstacles => _obstacles;

  Future loadObstacles() async {
    String data =
        await rootBundle.loadString("assets/skate_dice/obstacles.json");
    final jsonResult = json.decode(data);
    return jsonResult
        .map<ObstacleHeader>(
            (obstacleHeader) => ObstacleHeader.fromJson(obstacleHeader))
        .toList();
  }
}
