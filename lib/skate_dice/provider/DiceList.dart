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
        diceList.clear();
        diceList.add(SkateDiceDice());
        diceList.add(SkateDiceDice());
      }

      else if (difficulty == Difficulty.Medium) {
        diceList.clear();
        diceList.add(SkateDiceDice());
        diceList.add(SkateDiceDice());
        diceList.add(SkateDiceDice());
      }

       else if (difficulty == Difficulty.Hard) {
        diceList.clear();
        diceList.add(SkateDiceDice());
        diceList.add(SkateDiceDice());
        diceList.add(SkateDiceDice());
        diceList.add(SkateDiceDice());
      }
    }
    notifyListeners();
  }
}
