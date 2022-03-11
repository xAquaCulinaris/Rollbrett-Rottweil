import 'package:flutter/material.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/widgets/DifficultySettingsItems/DifficultyItem.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/widgets/DifficultySettingsItems/DifficultyItemHeader.dart';
import 'package:rollbrett_rottweil/skate_dice/widgets/skate_dice_dice.dart';

class SettingsProvider extends ChangeNotifier {
  //diificulty modes
  Difficulty gameDifficulty = Difficulty.Easy;
  String currentDiceCount = "2";
  Difficulty trickDifficulty = Difficulty.Easy;

  //dices which display the trick
  List<SkateDiceDice> _diceList = [SkateDiceDice(), SkateDiceDice()];

  //getter for dice list
  List<SkateDiceDice> get diceList => _diceList;

  //game difficulty option menu
  DifficultyItemHeader gameDifficultyHeader =
      DifficultyItemHeader("Game Difficulty", [
    DifficultyItem("Easy", true),
    DifficultyItem("Medium", false),
    DifficultyItem("Hard", false)
  ]);

  //game difficulty option menu
  DifficultyItemHeader trickDifficultyHeader =
      DifficultyItemHeader("Trick Difficulty", [
    DifficultyItem("Easy", true),
    DifficultyItem("Medium", false),
    DifficultyItem("Hard", false)
  ]);

  void updateGameDifficulty(String diceCount,
      {bool updateCurrentDiceCount = true}) {
    if (diceCount != currentDiceCount) {
      if (diceCount == "2") {
        if (gameDifficulty == Difficulty.Hard) diceList.removeLast();
        diceList.removeLast();

        gameDifficultyHeader.items[0].checked = true;
        gameDifficultyHeader.items[1].checked = false;
        gameDifficultyHeader.items[2].checked = false;
        gameDifficulty = Difficulty.Easy;
      } else if (diceCount == "3" || diceCount == "Random") {
        if (gameDifficulty == Difficulty.Easy)
          diceList.add(SkateDiceDice());
        else
          diceList.removeLast();

        gameDifficultyHeader.items[0].checked = false;
        gameDifficultyHeader.items[1].checked = true;
        gameDifficultyHeader.items[2].checked = false;
        gameDifficulty = Difficulty.Medium;
      } else if (diceCount == "4") {
        if (gameDifficulty == Difficulty.Easy) diceList.add(SkateDiceDice());
        diceList.add(SkateDiceDice());

        gameDifficultyHeader.items[0].checked = false;
        gameDifficultyHeader.items[1].checked = false;
        gameDifficultyHeader.items[2].checked = true;
        gameDifficulty = Difficulty.Hard;
      }
    }
    //only update if updateCurrentDiceCount is true (false when using random mode)
    if (updateCurrentDiceCount) currentDiceCount = diceCount;
    notifyListeners();
  }

  void updateTrickDifficulty(Difficulty difficulty) {
    if (difficulty != trickDifficulty) {
      if (difficulty == Difficulty.Easy) {
        trickDifficultyHeader.items[0].checked = true;
        trickDifficultyHeader.items[1].checked = false;
        trickDifficultyHeader.items[2].checked = false;
      } else if (difficulty == Difficulty.Medium) {
        trickDifficultyHeader.items[0].checked = false;
        trickDifficultyHeader.items[1].checked = true;
        trickDifficultyHeader.items[2].checked = false;
      } else if (difficulty == Difficulty.Hard) {
        trickDifficultyHeader.items[0].checked = false;
        trickDifficultyHeader.items[1].checked = false;
        trickDifficultyHeader.items[2].checked = true;
      }
    }
    trickDifficulty = difficulty;
    notifyListeners();
  }
}

enum Difficulty { Hard, Medium, Easy }
