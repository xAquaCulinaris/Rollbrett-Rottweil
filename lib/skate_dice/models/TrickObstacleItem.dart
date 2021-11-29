

//The actual item inside a group
import 'package:rollbrett_rottweil/skate_dice/models/ItemInterface.dart';

class TrickObstacleItem extends ItemInterface{
  
  ObstacleType obstacleType;

  TrickObstacleItem(String name, String obstacleType) {
    this.name = name;
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