abstract class ItemInterface {
  String name;
  bool directional;
  bool checked = true;
  ExtendedDifficulty difficulty;
}

enum ExtendedDifficulty { easy, medium, advanced, expert }