import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rollbrett_rottweil/skate_dice/models/ItemInterface.dart';
import 'package:rollbrett_rottweil/skate_dice/models/TrickObstacleItem.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/providers/ObstacleProvider.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/providers/SettingProvider.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/providers/TrickProvider.dart';
import 'package:quiver/collection.dart';

class GenerateTrick {
  static GenerateTrick _instance;
  ObstacleProvider providerObstacle;
  TrickProvider providerTrick;
  SettingsProvider settingProvider;
  final List<String> directions = ["FS", "BS"];
  final List<String> stances = [
    "Regular",
    "Regular",
    "Regular",
    "Regular",
    "Regular",
    "Fakie",
    "Fakie",
    "Fakie",
    "Switch",
    "Nollie"
  ];

  GenerateTrick._(BuildContext context) {
    providerObstacle = Provider.of<ObstacleProvider>(context, listen: false);
    providerTrick = Provider.of<TrickProvider>(context, listen: false);
    settingProvider = Provider.of<SettingsProvider>(context, listen: false);
  }

  static GenerateTrick getInstace(BuildContext context) {
    if (_instance == null) _instance = GenerateTrick._(context);
    return _instance;
  }

  String _getRandomDirection() {
    return directions[Random().nextInt(directions.length)];
  }

  String _getRandomStance() {
    return stances[Random().nextInt(stances.length)];
  }

  List<String> generateTrick() {
    List<String> diceTexts = [];

    Difficulty gameDifficulty = settingProvider.gameDifficulty;
    Difficulty trickDifficulty = settingProvider.trickDifficulty;
    int numberDices = settingProvider.diceList.length;

    var easyDifficultyMap = Multimap<ExtendedDifficulty, ExtendedDifficulty>();
    easyDifficultyMap.add(ExtendedDifficulty.easy, ExtendedDifficulty.easy);
    easyDifficultyMap.add(ExtendedDifficulty.easy, ExtendedDifficulty.medium);
    easyDifficultyMap.add(ExtendedDifficulty.medium, ExtendedDifficulty.easy);

    var mediumDifficultyMap =
        Multimap<ExtendedDifficulty, ExtendedDifficulty>();
    mediumDifficultyMap.add(
        ExtendedDifficulty.easy, ExtendedDifficulty.advanced);
    mediumDifficultyMap.add(
        ExtendedDifficulty.medium, ExtendedDifficulty.medium);
    mediumDifficultyMap.add(
        ExtendedDifficulty.advanced, ExtendedDifficulty.easy);
    mediumDifficultyMap.add(
        ExtendedDifficulty.advanced, ExtendedDifficulty.medium);

    var hardDifficultyMap = Multimap<ExtendedDifficulty, ExtendedDifficulty>();
    hardDifficultyMap.add(
        ExtendedDifficulty.medium, ExtendedDifficulty.advanced);
    hardDifficultyMap.add(ExtendedDifficulty.medium, ExtendedDifficulty.expert);
    hardDifficultyMap.add(ExtendedDifficulty.expert, ExtendedDifficulty.medium);
    hardDifficultyMap.add(
        ExtendedDifficulty.advanced, ExtendedDifficulty.advanced);
    hardDifficultyMap.add(ExtendedDifficulty.easy, ExtendedDifficulty.expert);

    //obstacle and trick which are randomly choosen by difficulty
    TrickObstacleItem obstacle;
    TrickObstacleItem trick;

    //TODO obstacle provider doesnt load obstacles on startup

    //easy
    if (trickDifficulty == Difficulty.Easy) {
      obstacle = _getObstacleByDifficultyMap(easyDifficultyMap);
      if (obstacle == null) return List<String>.empty();

      trick = _getTrickByDifficultyMapAndObstacle(easyDifficultyMap, obstacle);
    }
    //medium
    else if (trickDifficulty == Difficulty.Medium) {
      obstacle = _getObstacleByDifficultyMap(mediumDifficultyMap);
      if (obstacle == null) return List<String>.empty();

      trick =
          _getTrickByDifficultyMapAndObstacle(mediumDifficultyMap, obstacle);
    }
    //hard
    else if (trickDifficulty == Difficulty.Hard) {
      obstacle = _getObstacleByDifficultyMap(hardDifficultyMap);
      if (obstacle == null) return List<String>.empty();

      trick = _getTrickByDifficultyMapAndObstacle(hardDifficultyMap, obstacle);
    }

    if (trick == null) return List<String>.empty();

    switch (gameDifficulty) {
      case Difficulty.Easy:
        diceTexts.add(trick.name);
        diceTexts.add(obstacle.name);
        break;
      case Difficulty.Medium:
        diceTexts.add(_getRandomStance());
        diceTexts.add(trick.name);
        diceTexts.add(obstacle.name);
        break;
      case Difficulty.Hard:
        diceTexts.add(_getRandomStance());
        if (trick.directional) {
          diceTexts.add(_getRandomDirection());
          diceTexts.add(trick.name);
          diceTexts.add(obstacle.name);
        } else {
          diceTexts.add(trick.name);
          diceTexts.add(obstacle.name);
          diceTexts.add("Placeholder");
        }

        break;
    }

    return diceTexts;
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
}
