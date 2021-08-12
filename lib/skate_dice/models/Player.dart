import 'package:flutter/material.dart';

class Player {
  Player(this.name);
  final String name;
  int letters = 0;
}

class PlayerList extends ChangeNotifier {
  List<Player> _players = [];

  List<Player> get players => _players;

  void addPlayer(String name) {
    _players.add(Player(name));
    notifyListeners();
  }

  void removePlayer(String name) {
    _players.removeWhere((p) => p.name == name);
    notifyListeners();
  }
}
