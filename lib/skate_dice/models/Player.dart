import 'package:flutter/material.dart';

class Player {
  Player(this.name);
  final String name;
  int letters = 0;
}

class PlayerList extends ChangeNotifier {
  List<Player> _players = [Player("marian")];

  List<Player> get players => _players;

  void addPlayer(String name) {
    _players.add(Player(name));
    notifyListeners();
  }

  String removePlayer(int index) {
    String name = _players.removeAt(index).name;
    notifyListeners();
    return name;
  }
}
