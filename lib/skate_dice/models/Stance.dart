import 'package:rollbrett_rottweil/skate_dice/models/ItemInterface.dart';

class Stance {
  const Stance(this.name, this.difficulty);
  final String name;
  final ExtendedDifficulty difficulty;

  static List<Stance> _stances = [
    Stance("Regular", ExtendedDifficulty.easy),
    Stance("Fakie", ExtendedDifficulty.medium),
    Stance("Nollie", ExtendedDifficulty.advanced),
    Stance("Switch", ExtendedDifficulty.expert)
  ];

  //get a list of available stances mapped by diffyculty 
  static List<Stance> getStancesByDifficulty(ExtendedDifficulty maxDifficulty) {
    List<ExtendedDifficulty> difficultys = [];
    List<Stance> availableStances = [];

    //add all difficultys below maxDiffculty
    if(maxDifficulty == ExtendedDifficulty.easy)
      difficultys.add(maxDifficulty);
    if (maxDifficulty == ExtendedDifficulty.medium) {
      difficultys.add(ExtendedDifficulty.easy);
      difficultys.add(ExtendedDifficulty.easy);
      difficultys.add(maxDifficulty);
    } else if (maxDifficulty == ExtendedDifficulty.advanced) {
      difficultys.add(ExtendedDifficulty.easy);
      difficultys.add(ExtendedDifficulty.easy);
      difficultys.add(ExtendedDifficulty.easy);
      difficultys.add(ExtendedDifficulty.medium);
      difficultys.add(ExtendedDifficulty.medium);
      difficultys.add(maxDifficulty);
    } else if (maxDifficulty == ExtendedDifficulty.expert) {
      difficultys.add(ExtendedDifficulty.easy);
      difficultys.add(ExtendedDifficulty.easy);
      difficultys.add(ExtendedDifficulty.easy);
      difficultys.add(ExtendedDifficulty.medium);
      difficultys.add(ExtendedDifficulty.medium);
      difficultys.add(ExtendedDifficulty.medium);
      difficultys.add(ExtendedDifficulty.advanced);
      difficultys.add(ExtendedDifficulty.advanced);
      difficultys.add(maxDifficulty);
    }

    //add current difficultys
    difficultys.add(maxDifficulty);

    for (Stance stance in _stances) {
      for(ExtendedDifficulty difficulty in difficultys)
        if (stance.difficulty == difficulty) availableStances.add(stance) ;
    }

    return availableStances;
  }
}


// is used to choose stance by obstacle and trick diffculty
class ObstacleTrickStanceDifficulty {
  const ObstacleTrickStanceDifficulty(
      this.obstacleDifficulty, this.trickDifficulty, this.stanceDifficulty);

  final ExtendedDifficulty obstacleDifficulty;
  final ExtendedDifficulty trickDifficulty;
  final ExtendedDifficulty stanceDifficulty;
}
