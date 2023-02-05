import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rollbrett_rottweil/course_preview/provider/obstacle.dart';

class CoursePreviewObstaclesProvider extends ChangeNotifier {
  bool obstaclesLoaded = false;
  List<Obstacle> _obstacles = [];

  List<Obstacle> get obstacles => _obstacles;

  CoursePreviewObstaclesProvider() {
    if (_obstacles == null || _obstacles.length == 0) loadObstacles();
  }

  void loadObstacles() {
    _loadObstacles().then((obstacles) {
      _obstacles = obstacles;
      notifyListeners();
      obstaclesLoaded = true;
      print("loaded obstacles for course_preview");
    });
  }

  void addUidInRange(String uid) {
    for (Obstacle obstacle in _obstacles) {
      if (obstacle.uid == uid) obstacle.inRange = true;
    }

    notifyListeners();
  }

  void resetInRange() {
    for (Obstacle obstacle in _obstacles) {
      if (obstacle.inRange) obstacle.inRange = false;
    }
  }

  Future _loadObstacles() async {
    String data =
        await rootBundle.loadString("assets/course_preview/obstacles.json");
    final jsonResult = json.decode(data);
    return jsonResult
        .map<Obstacle>((obstacleHeader) => Obstacle.fromJson(obstacleHeader))
        .toList();
  }

  Obstacle getObstacleByName(String name) {
    for (Obstacle obstacle in obstacles) {
      if (obstacle.name == name) return obstacle;
    }
    return null;
  }
}
