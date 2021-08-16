import 'package:flutter/cupertino.dart';

class SettingsProvider with ChangeNotifier {
  Difficulty _difficulty = Difficulty.easy;
  bool _showStance = false;
  bool _showDirections = false;

//TODO maybe add later
  // bool tricksIntoGrind = false;
  // bool tricksOutOfGrind = false;

  Difficulty get difficulty => this._difficulty;

  set difficulty(Difficulty value) => this._difficulty = value;

  void setStance(bool value) => this._showStance = value;

  bool getStance() => this._showStance;

  get showDirections => this._showDirections;

  set showDirections(value) => this._showDirections = value;
}

enum Difficulty { easy, medium, hard, none }
