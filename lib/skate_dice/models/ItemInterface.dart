abstract class ItemInterface {
  String name;
  bool directional;
  bool checked = true;
  ExtendedDifficulty difficulty;

  String get obstacleLink => null;
}

enum ExtendedDifficulty { easy, medium, advanced, expert }