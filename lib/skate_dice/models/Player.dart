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

  String removePlayer(int index) {
    String name = _players.removeAt(index).name;
    notifyListeners();
    return name;
  }

  void restartGame() {
    for (Player player in _players) {
      player.letters = 0;
    }
    notifyListeners();
  }

  String getWinnerName() {
    if (_players.length >= 2) {
      int counter = 0;
      Player winner;

      //check how manny players have 5 letters
      for (Player player in _players) {
        if (player.letters == 5)
          counter++;
        else
          winner = player;
      }
      if (counter == _players.length - 1) return winner.name;
    }
    return null;
  }
}
