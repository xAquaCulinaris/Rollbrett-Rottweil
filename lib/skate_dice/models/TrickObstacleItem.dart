

//The actual item inside a group
import 'package:rollbrett_rottweil/skate_dice/models/ItemInterface.dart';

class TrickObstacleItem extends ItemInterface{
  
  ObstacleType obstacleType;
  String obstacleLink;

  TrickObstacleItem(String name, String obstacleType, bool directional, String difficulty, String obstacleLink) {
    this.name = name;
    this.directional = directional;
    this.difficulty = ExtendedDifficulty.values.firstWhere((e) => e.toString() == "ExtendedDifficulty."+difficulty);
    this.obstacleLink = obstacleLink;
    switch (obstacleType) {
      case 'flat':
        this.obstacleType = ObstacleType.Flat;
        break;
      case 'grind':
        this.obstacleType = ObstacleType.Grind;
        break;
      case 'manual':
        this.obstacleType = ObstacleType.Manual;
        break;
      case 'transition':
        this.obstacleType = ObstacleType.Transition;
        break;
    }
  }

}

enum ObstacleType { Flat, Grind, Manual, Transition }
