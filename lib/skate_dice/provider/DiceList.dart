import 'package:flutter/material.dart';
import 'package:rollbrett_rottweil/skate_dice/provider/SettingProvider.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_dice.dart';

class DiceList extends ChangeNotifier {
  Difficulty currentDifficulty = Difficulty.Easy;
  List<SkateDiceDice> _diceList = [SkateDiceDice(), SkateDiceDice()];

  List<SkateDiceDice> get diceList => _diceList;

  void updateDifficulty(Difficulty difficulty) {
    if (difficulty != currentDifficulty) {
      if (difficulty == Difficulty.Easy) {
        if (currentDifficulty == Difficulty.Hard) diceList.removeLast();
        diceList.removeLast();
      } else if (difficulty == Difficulty.Medium) {
        if (currentDifficulty == Difficulty.Easy)
          diceList.add(SkateDiceDice());
        else
          diceList.removeLast();
      } else if (difficulty == Difficulty.Hard) {
        if (currentDifficulty == Difficulty.Easy)
          diceList.add(SkateDiceDice());
        diceList.add(SkateDiceDice());
      }
    }
    currentDifficulty = difficulty;
    notifyListeners();
  }
}
