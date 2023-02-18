import 'package:flutter/material.dart';
import 'package:rollbrett_rottweil/skate_dice_new/models/player.dart';

class PlayerList extends ChangeNotifier {
  //list of all players in game
  List<Player> _players = [];

  //get the list of all palyers
  List<Player> get players => _players;

  //add new player to game
  void addPlayer(String name) {
    _players.add(Player(name));
    notifyListeners();
  }

  //remove player from current game
  String removePlayer(int index) {
    String name = _players.removeAt(index).name;
    notifyListeners();
    return name;
  }

  //reset all the player scores
  void restartGame() {
    for (Player player in _players) {
      player.letters = 0;
    }
    notifyListeners();
  }

  //returns the name of the player that has won
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
