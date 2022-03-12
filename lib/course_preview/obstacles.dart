import 'package:flutter/material.dart';

class Obstacle {
  Obstacle(this.name, this.imagePath, this.uid);

  final String name;
  final String imagePath;
  final String uid;
  bool inRange = false;
}

class CoursePreviewObstaclesProvider extends ChangeNotifier {
  CoursePreviewObstaclesProvider() {
    Obstacle stair =
        Obstacle("Stair", "assets/images/stair.jpeg", "EE:22:E1:46:D4:82");
    Obstacle rail =
        Obstacle("Rail", "assets/images/rail.jpg", "EE:22:E1:46:D4:81");
    Obstacle ledge =
        Obstacle("Ledge", "assets/images/ledge.jpg", "EE:22:E1:46:D4:81");
    Obstacle hubba =
        Obstacle("Hubba", "assets/images/hubba.jpg", "EE:22:E1:46:D4:81");
    Obstacle mannypad = Obstacle(
        "Mannypad", "assets/images/mannypad.jpeg", "EE:22:E1:46:D4:81");
    Obstacle rollbrett = Obstacle("Rollbrett",
        "assets/images/rollbrett_rottweil.jpg", "EE:22:E1:46:D4:81");

    //stair.inRange = true;
    //rail.inRange = true;
    _obstacles.addAll([stair, rail, ledge, hubba, mannypad, rollbrett]);
  }

  List<Obstacle> _obstacles = [];

  List<Obstacle> get obstacles => _obstacles;

  void addUidInRange(String uid) {
    for (Obstacle obstacle in _obstacles) {
      if (obstacle.uid == uid) obstacle.inRange = true;
    }

    notifyListeners();
  }
}
