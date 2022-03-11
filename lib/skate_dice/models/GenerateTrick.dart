import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rollbrett_rottweil/skate_dice/models/ItemInterface.dart';
import 'package:rollbrett_rottweil/skate_dice/models/Stance.dart';
import 'package:rollbrett_rottweil/skate_dice/models/TrickObstacleItem.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/providers/ObstacleProvider.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/providers/SettingProvider.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/providers/TrickProvider.dart';
import 'package:quiver/collection.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/widgets/DifficultySettingsItems/DifficultyItem.dart';

class GenerateTrick {
  static GenerateTrick _instance;
  ObstacleProvider providerObstacle;
  TrickProvider providerTrick;
  SettingsProvider settingProvider;
  final List<String> directions = ["FS", "BS"];
  //create difficulty maps
  var easyDifficultyMap = Multimap<ExtendedDifficulty, ExtendedDifficulty>();
  var mediumDifficultyMap = Multimap<ExtendedDifficulty, ExtendedDifficulty>();
  var hardDifficultyMap = Multimap<ExtendedDifficulty, ExtendedDifficulty>();

  List<ObstacleTrickStanceDifficulty> easyStanceDifficultyMap = [];
  List<ObstacleTrickStanceDifficulty> mediumStanceDifficultyMap = [];
  List<ObstacleTrickStanceDifficulty> hardStanceDifficultyMap = [];

  GenerateTrick._(BuildContext context) {
    providerObstacle = Provider.of<ObstacleProvider>(context, listen: false);
    providerTrick = Provider.of<TrickProvider>(context, listen: false);
    settingProvider = Provider.of<SettingsProvider>(context, listen: false);

    //setup difficulty maps
    loadDifficultyMaps();
  }

  void loadDifficultyMaps() {
    //obstacle trick diffculty
    easyDifficultyMap.add(ExtendedDifficulty.easy, ExtendedDifficulty.easy);
    easyDifficultyMap.add(ExtendedDifficulty.easy, ExtendedDifficulty.medium);
    easyDifficultyMap.add(ExtendedDifficulty.medium, ExtendedDifficulty.easy);

    mediumDifficultyMap.add(
        ExtendedDifficulty.easy, ExtendedDifficulty.advanced);
    mediumDifficultyMap.add(
        ExtendedDifficulty.medium, ExtendedDifficulty.medium);
    mediumDifficultyMap.add(
        ExtendedDifficulty.medium, ExtendedDifficulty.advanced);
    mediumDifficultyMap.add(
        ExtendedDifficulty.advanced, ExtendedDifficulty.easy);
    mediumDifficultyMap.add(
        ExtendedDifficulty.advanced, ExtendedDifficulty.medium);
    mediumDifficultyMap.add(ExtendedDifficulty.easy, ExtendedDifficulty.expert);

    hardDifficultyMap.add(
        ExtendedDifficulty.medium, ExtendedDifficulty.advanced);
    hardDifficultyMap.add(ExtendedDifficulty.medium, ExtendedDifficulty.expert);
    hardDifficultyMap.add(ExtendedDifficulty.expert, ExtendedDifficulty.medium);
    hardDifficultyMap.add(
        ExtendedDifficulty.advanced, ExtendedDifficulty.advanced);
    hardDifficultyMap.add(ExtendedDifficulty.easy, ExtendedDifficulty.expert);

    //easy stance
    easyStanceDifficultyMap.add(ObstacleTrickStanceDifficulty(
        ExtendedDifficulty.easy,
        ExtendedDifficulty.easy,
        ExtendedDifficulty.medium));
    easyStanceDifficultyMap.add(ObstacleTrickStanceDifficulty(
        ExtendedDifficulty.medium,
        ExtendedDifficulty.easy,
        ExtendedDifficulty.easy));
    easyStanceDifficultyMap.add(ObstacleTrickStanceDifficulty(
        ExtendedDifficulty.easy,
        ExtendedDifficulty.medium,
        ExtendedDifficulty.easy));

    //medium stance
    mediumStanceDifficultyMap.add(ObstacleTrickStanceDifficulty(
        ExtendedDifficulty.easy,
        ExtendedDifficulty.advanced,
        ExtendedDifficulty.medium));
    mediumStanceDifficultyMap.add(ObstacleTrickStanceDifficulty(
        ExtendedDifficulty.medium,
        ExtendedDifficulty.medium,
        ExtendedDifficulty.advanced));
    mediumStanceDifficultyMap.add(ObstacleTrickStanceDifficulty(
        ExtendedDifficulty.medium,
        ExtendedDifficulty.advanced,
        ExtendedDifficulty.medium));
    mediumStanceDifficultyMap.add(ObstacleTrickStanceDifficulty(
        ExtendedDifficulty.advanced,
        ExtendedDifficulty.easy,
        ExtendedDifficulty.advanced));
    mediumStanceDifficultyMap.add(ObstacleTrickStanceDifficulty(
        ExtendedDifficulty.advanced,
        ExtendedDifficulty.medium,
        ExtendedDifficulty.medium));

    //hard stance
    hardStanceDifficultyMap.add(ObstacleTrickStanceDifficulty(
        ExtendedDifficulty.medium,
        ExtendedDifficulty.advanced,
        ExtendedDifficulty.advanced));
    hardStanceDifficultyMap.add(ObstacleTrickStanceDifficulty(
        ExtendedDifficulty.medium,
        ExtendedDifficulty.expert,
        ExtendedDifficulty.medium));
    hardStanceDifficultyMap.add(ObstacleTrickStanceDifficulty(
        ExtendedDifficulty.expert,
        ExtendedDifficulty.medium,
        ExtendedDifficulty.medium));
    hardStanceDifficultyMap.add(ObstacleTrickStanceDifficulty(
        ExtendedDifficulty.advanced,
        ExtendedDifficulty.advanced,
        ExtendedDifficulty.expert));
    hardStanceDifficultyMap.add(ObstacleTrickStanceDifficulty(
        ExtendedDifficulty.easy,
        ExtendedDifficulty.expert,
        ExtendedDifficulty.expert));
  }

  static GenerateTrick getInstace(BuildContext context) {
    if (_instance == null) _instance = GenerateTrick._(context);
    return _instance;
  }

  //return random direction (BS/FS)
  String _getRandomDirection() {
    return directions[Random().nextInt(directions.length)];
  }

  //return Stance by current difficulty settings
  String _getRandomStance(
      ExtendedDifficulty obstacleDifficulty,
      ExtendedDifficulty trickDifficulty,
      List<ObstacleTrickStanceDifficulty> difficultyMap) {
    List<Stance> availableStances = [];

    //add possible stances to list, filter them by obstacle and trick diffculty
    for (ObstacleTrickStanceDifficulty obstacleTrickDifficulty
        in difficultyMap) {
      if (obstacleDifficulty == obstacleTrickDifficulty.obstacleDifficulty &&
          trickDifficulty == obstacleTrickDifficulty.trickDifficulty)
        availableStances = Stance.getStancesByDifficulty(
            obstacleTrickDifficulty.stanceDifficulty);
    }

    //if no was found return regular else choose random from avilable
    if (availableStances.isEmpty) {
      print("no matching stance was found");
      return "Regular";
    } else
      return availableStances[Random().nextInt(availableStances.length)].name;
  }

  //generate a complete new trick
  List<String> generateTrick() {
    //if diceCount == Random upadte dices to random dice count
  /*  if (settingProvider.currentDiceCount == "Random") {
      List<String> diceCountPossibilities = ["2", "3", "4"];
      settingProvider.updateGameDifficulty(diceCountPossibilities[
          Random().nextInt(diceCountPossibilities.length)], updateCurrentDiceCount: false);
    }*/
    Difficulty gameDifficulty = settingProvider.gameDifficulty;
    Difficulty trickDifficulty = settingProvider.trickDifficulty;

    //obstacle and trick which are randomly choosen by difficulty
    TrickObstacleItem obstacle;
    TrickObstacleItem trick;

    //stores the map for the current difficulty
    Multimap<ExtendedDifficulty, ExtendedDifficulty> currentDifficultyMap;
    List<ObstacleTrickStanceDifficulty> currentStanceDifficultyMap;

    //set the current difficulty map by trickDiffculty setting
    switch (trickDifficulty) {
      case Difficulty.Easy:
        currentDifficultyMap = easyDifficultyMap;
        currentStanceDifficultyMap = easyStanceDifficultyMap;
        break;
      case Difficulty.Medium:
        currentDifficultyMap = mediumDifficultyMap;
        currentStanceDifficultyMap = mediumStanceDifficultyMap;
        break;
      case Difficulty.Hard:
        currentDifficultyMap = hardDifficultyMap;
        currentStanceDifficultyMap = hardStanceDifficultyMap;
        break;
    }

    //get random obstacle
    obstacle = _getObstacleByDifficultyMap(currentDifficultyMap);
    if (obstacle == null) return List<String>.empty();

    //get random trick that matches obstacle and diffculty
    trick = _getTrickByDifficultyMapAndObstacle(currentDifficultyMap, obstacle);

    //if not possible trick was found
    if (trick == null) return List<String>.empty();

    return writeTrickToList(
        gameDifficulty, trick, obstacle, currentStanceDifficultyMap);
  }

  List<String> writeTrickToList(
      Difficulty gameDifficulty,
      TrickObstacleItem trick,
      TrickObstacleItem obstacle,
      List<ObstacleTrickStanceDifficulty> currentStanceDifficultyMap) {
    List<String> diceTexts = [];

    switch (gameDifficulty) {
      case Difficulty.Easy:
        diceTexts.add(trick.name);
        diceTexts.add(obstacle.name);
        break;
      case Difficulty.Medium:
        //if grindable obstacle 25% change of getting trick to fakie else random stance get choosen
        if (toFakieOrNot(obstacle)) {
          diceTexts.add(trick.name);
          diceTexts.add("to fakie");
          diceTexts.add(obstacle.name);
          return diceTexts;
        } else {
          //10% chance to get easy/medium trick into grind
          String trickName =
              trickIntoGrindOrNot(obstacle, ExtendedDifficulty.medium);
          if (trickName != null)
            diceTexts.add(trickName);

          //66% chance to get direction
          else if (directionOrNot(trick))
            diceTexts.add(_getRandomDirection());
          //33% chance to get stance
          else
            diceTexts.add(_getRandomStance(obstacle.difficulty,
                trick.difficulty, currentStanceDifficultyMap));
          diceTexts.add(trick.name);
          diceTexts.add(obstacle.name);
        }
        break;

      case Difficulty.Hard:
        diceTexts.add(_getRandomStance(
            obstacle.difficulty, trick.difficulty, currentStanceDifficultyMap));
        if (trick.directional) {
          diceTexts.add(_getRandomDirection());
          diceTexts.add(trick.name);
          diceTexts.add(obstacle.name);
        } else {
          diceTexts.add(trick.name);
          diceTexts.add(obstacle.name);
        }

        break;
    }
    return diceTexts;
  }

  //if grindable obstacle 25% change of getting trick to fakie
  bool toFakieOrNot(TrickObstacleItem obstacle) {
    if (obstacle.obstacleType == ObstacleType.Grind) {
      //25% chance
      if (Random().nextInt(4) == 0) return true;
    }
    return false;
  }

  //if trick can be done fs or bs 66% chance that direction is displayed
  bool directionOrNot(TrickObstacleItem trick) {
    if (trick.directional) {
      int random = Random().nextInt(3);
      if (random == 0 || random == 1) return true;
    }
    return false;
  }

  String trickIntoGrindOrNot(
      TrickObstacleItem obstacle, ExtendedDifficulty difficulty) {
    if (obstacle.obstacleType == ObstacleType.Grind ||
        obstacle.obstacleType == ObstacleType.Manual) {
      if (Random().nextInt(10) == 0) {
        TrickObstacleItem trick = _getTrickIntoGrindByMaxDifficulty(difficulty);
        return trick.name;
      }
    }

    return null;
  }

  //get random obstacle with correct difficutly
  TrickObstacleItem _getObstacleByDifficultyMap(
      Multimap<ExtendedDifficulty, ExtendedDifficulty> difficultyMap) {
    List<TrickObstacleItem> obstacles = [];

    //Add all obstacles by difficulty to list of obstacles
    List<ExtendedDifficulty> addedDifficultys = [];

    difficultyMap.forEach((key, value) {
      //only add if not already added
      if (!addedDifficultys.contains(key)) {
        obstacles.addAll(providerObstacle.getObstaclesByDifficulty(key));
        addedDifficultys.add(key);
      }
    });

    //return random obstacle
    if (obstacles.length > 0)
      return obstacles[Random().nextInt(obstacles.length)];
    else
      return null;
  }

  //get random trick which matches difficulty and obstacle type
  TrickObstacleItem _getTrickByDifficultyMapAndObstacle(
      Multimap<ExtendedDifficulty, ExtendedDifficulty> difficultyMap,
      TrickObstacleItem obstacle) {
    List<TrickObstacleItem> tricks = [];

    //check in difficulty map which trick difficultys should be added to list of tricks
    difficultyMap.forEach((key, value) {
      if (obstacle.difficulty == key)
        tricks.addAll(providerTrick.getTrickByDifficultyAndType(
            value, obstacle.obstacleType));
    });

    //return random trick
    if (tricks.length > 0)
      return tricks[Random().nextInt(tricks.length)];
    else
      return null;
  }

  //TODO update for hard difficulty
  //get trick into grind by difficulty
  TrickObstacleItem _getTrickIntoGrindByMaxDifficulty(
      ExtendedDifficulty difficulty) {
    List<TrickObstacleItem> availableTricks = [];
    if (difficulty == ExtendedDifficulty.medium) {
      availableTricks.addAll(providerTrick.getTrickByDifficultyAndType(
          difficulty, ObstacleType.Flat));
      availableTricks.addAll(providerTrick.getTrickByDifficultyAndType(
          ExtendedDifficulty.medium, ObstacleType.Flat));
    }

    //get random trick from this list (except ollie)
    if (availableTricks.length > 0) {
      TrickObstacleItem trick;
      trick = availableTricks[Random().nextInt(availableTricks.length)];
      //if trick was ollie reroll until not ollie
      while (trick.name == "Ollie")
        trick = availableTricks[Random().nextInt(availableTricks.length)];
      return trick;
    }
    print("trick into grind went wrong");
    return null;
  }
}
