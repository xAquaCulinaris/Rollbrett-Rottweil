import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rollbrett_rottweil/skate_dice/models/TrickObstacleItem.dart';
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
    settingProvider = Provider.of<SettingsProvider>(context, listen: false);
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
    List<String> diceTexts = [];
    //TODO function shouldnt be called every time
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

    if (settingProvider.getShowStance()) {
      diceTexts.add(_getRandomStance());
    }

    if (settingProvider.getShowDirections() && _trick.directional) {
      diceTexts.add(_getRandomDirection() + "\n" + _trick.name);
    } else {
      diceTexts.add(_trick.name);
    }

    diceTexts.add(_obstacle.name);

    if (settingProvider.getTrickIntoGrind()) {
      //TODO  handle
    }

    //fill array with empty entrys
    _fillTrick(diceTexts);

    return diceTexts;
  }

  _fillTrick(List<String> diceTexts) {
    for (int i = diceTexts.length; i < 4; i++) {
      diceTexts.add("");
    }
  }
}