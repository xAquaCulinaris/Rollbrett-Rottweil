import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Obstacle {
  Obstacle(this.name, this.imagePath, this.uid);

  factory Obstacle.fromJson(Map<String, dynamic> json) {
    String name = json['name'];
    String imagePath = json['image'];
    String uid = json['uid'];

    return Obstacle(name, imagePath, uid);
  }

  final String name;
  final String imagePath;
  final String uid;
  bool inRange = true;
}

class CoursePreviewObstaclesProvider extends ChangeNotifier {
  List<Obstacle> _obstacles = [];

  List<Obstacle> get obstacles => _obstacles;

  CoursePreviewObstaclesProvider() {
    if (_obstacles == null || _obstacles.length == 0) loadObstacles();
  }

  void loadObstacles() {
    _loadObstacles().then((obstacles) {
      _obstacles = obstacles;
      notifyListeners();
      print("loaded obstacles");
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
}
