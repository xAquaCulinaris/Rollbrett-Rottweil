import 'package:flutter/material.dart';

class Obstacle {
  Obstacle(this.name, this.imagePath);

  final String name;
  final String imagePath;


  static List getObstacles() {

  }
}

//TODO stopped working here
class ObstaclesProvider extends ChangeNotifier {
  ObstaclesProvider() {
    Obstacle stair = Obstacle("Stair", "assets/images/rollbrett_rottweil.jpg");
    Obstacle rail = Obstacle("Rail", "assets/images/rollbrett_rottweil.jpg");
  }
  
  List<Obstacle> obstacles = [];


}


