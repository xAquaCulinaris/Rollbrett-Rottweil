import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rollbrett_rottweil/skate_dice/models/TrickObstacleItem.dart';
import 'package:rollbrett_rottweil/skate_dice/provider/DiceList.dart';
import 'package:rollbrett_rottweil/skate_dice/provider/ObstacleProvider.dart';
import 'package:rollbrett_rottweil/skate_dice/provider/SettingProvider.dart';
import 'package:rollbrett_rottweil/skate_dice/provider/TrickProvider.dart';

class GenerateTrick {
  static GenerateTrick _instance;
  var providerObstacle;
  var providerTrick;
  var settingProvider;
  final List<String> directions = ["FS", "BS"];
  final List<String> stances = [
    "Regular",
    "Regular",
    "Regular",
    "Fakie",
    "Fakie",
    "Switch",
    "Nollie"
  ];

  GenerateTrick._(BuildContext context) {
    providerObstacle = Provider.of<ObstacleProvider>(context, listen: false);
    providerTrick = Provider.of<TrickProvider>(context, listen: false);
    settingProvider = Provider.of<DiceList>(context, listen: false);
  }

  static GenerateTrick getInstace(BuildContext context) {
    if (_instance == null) _instance = GenerateTrick._(context);
    return _instance;
  }

  TrickObstacleItem _getTrick(
      List<TrickObstacleItem> _tricks, TrickObstacleItem _obstacle) {
    List<TrickObstacleItem> _possibleTricks = [];

    _possibleTricks.addAll(_tricks
        .where((element) => element.obstacleType == _obstacle.obstacleType));
    if (_possibleTricks.length > 0)
      return _possibleTricks[Random().nextInt(_possibleTricks.length)];
    else
      return null;
  }

  String _getRandomDirection() {
    return directions[Random().nextInt(directions.length)];
  }

  String _getRandomStance() {
    return stances[Random().nextInt(stances.length)];
  }

  List<String> generateTrick() {
    //TODO function shouldnt be called every time
    List<String> diceTexts = [];
    
    //Get all selected obstacles
    List<TrickObstacleItem> _obstacles =
        providerObstacle.getSelectedObstacles();
    //Get all selected tricks
    List<TrickObstacleItem> _tricks = providerTrick.getSelectedTricks();
    
    // Choose random obsacle
    TrickObstacleItem _obstacle;
    if (_obstacles.length > 0)
      _obstacle = _obstacles[Random().nextInt(_obstacles.length)];
    else
      return List<String>.empty();

    //Choose random trick from available obstacle
    TrickObstacleItem _trick = _getTrick(_tricks, _obstacle);
    if (_trick == null) return List<String>.empty();

    switch (settingProvider.currentDifficulty) {
      case Difficulty.Easy:
        diceTexts.add(_trick.name);
        diceTexts.add(_obstacle.name);
        break;
      case Difficulty.Medium:
        diceTexts.add(_getRandomStance());
        diceTexts.add(_trick.name);
        diceTexts.add(_obstacle.name);
        break;
      case Difficulty.Hard:
        diceTexts.add(_getRandomStance());
        if (_trick.directional) {
          diceTexts.add(_getRandomDirection());
          diceTexts.add(_trick.name);
          diceTexts.add(_obstacle.name);
        } else {
          diceTexts.add(_trick.name);
          diceTexts.add(_obstacle.name);
          diceTexts.add("Placeholder");
        }

        break;
    }

    return diceTexts;
  }
}
