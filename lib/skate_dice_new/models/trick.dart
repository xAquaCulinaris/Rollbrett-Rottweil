import 'package:rollbrett_rottweil/skate_dice_new/models/enums/obstacle_types.dart';
import 'package:rollbrett_rottweil/skate_dice_new/models/enums/difficultys.dart';
import 'obstacle_trick_item_interface.dart';

class Trick extends ObstacleTrickItemInterface {
  Trick(
      String name,
      ExtendedDifficulty generalDifficulty,
      ExtendedDifficulty trickIntoDifficulty,
      ExtendedDifficulty stanceDifficulty,
      bool directional,
      ObstacleType obstacleType)
      : super(name, generalDifficulty, trickIntoDifficulty, stanceDifficulty,
            directional, obstacleType);
}
