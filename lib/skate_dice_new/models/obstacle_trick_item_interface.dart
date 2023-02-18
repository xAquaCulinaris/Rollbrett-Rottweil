import 'package:rollbrett_rottweil/skate_dice_new/models/checkbox_item.dart';
import 'enums/difficultys.dart';
import 'enums/obstacle_types.dart';

class ObstacleTrickItemInterface extends CheckBoxItem {
  ObstacleTrickItemInterface(
      String name,
      this.generalDifficulty,
      this.trickIntoDifficulty,
      this.stanceDifficulty,
      this.directional,
      this.obstacleType)
      : super(name);

  final ExtendedDifficulty generalDifficulty;
  final ExtendedDifficulty trickIntoDifficulty;
  final ExtendedDifficulty stanceDifficulty;
  final bool directional;
  final ObstacleType obstacleType;
}
