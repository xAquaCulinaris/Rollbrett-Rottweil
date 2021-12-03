import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rollbrett_rottweil/app_localizations.dart';
import 'package:rollbrett_rottweil/reusable/button.dart';
import 'package:rollbrett_rottweil/reusable/custom_app_bar.dart';
import 'package:rollbrett_rottweil/skate_dice/models/TrickObstacleItem.dart';
import 'package:rollbrett_rottweil/skate_dice/provider/ObstacleProvider.dart';
import 'package:rollbrett_rottweil/skate_dice/provider/SettingProvider.dart';
import 'package:rollbrett_rottweil/skate_dice/models/Player.dart';
import 'package:rollbrett_rottweil/skate_dice/provider/TrickProvider.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/nav_bar.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_dice.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_player.dart';
import 'dart:async';

class SkateDice extends StatelessWidget {
  final SkateDiceDice _dice1 = SkateDiceDice();
  final SkateDiceDice _dice2 = SkateDiceDice();
  final SkateDiceDice _dice3 = SkateDiceDice();
  final SkateDiceDice _dice4 = SkateDiceDice();
  final List<String> directions = ["FS", "BS"];
  //TODO change that because of difficulty (and maybe stance selection)
  final List<String> stances = [
    "Regular",
    "Regular",
    "Regular",
    "Fakie",
    "Fakie",
    "Switch",
    "Nollie"
  ];

  @override
  Widget build(BuildContext context) {
    final providerObstacle = Provider.of<ObstacleProvider>(context);
    final providerTrick = Provider.of<TrickProvider>(context);
    final settingProvider = Provider.of<SettingsProvider>(context);

    _settingButtonPressed() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NavBar(),
        ),
      );
    }

    List<TrickObstacleItem> _getPossibleTricks(
        List<TrickObstacleItem> _tricks, TrickObstacleItem _obstacle) {
      List<TrickObstacleItem> possibleTricks = [];

      possibleTricks.addAll(_tricks
          .where((element) => element.obstacleType == _obstacle.obstacleType));
      return possibleTricks;
    }

    _getRandomDirection() {
      return directions[Random().nextInt(2)];
    }

    _getRandomStance() {
      return stances[Random().nextInt(stances.length)];
    }

    //TODO handle difficulty
    _rollDiceButtonPressed() {
      List<String> diceTexts = [];

      //Get all selected obstacles
      List<TrickObstacleItem> _obstacles =
          providerObstacle.getSelectedObstacles();
      //Get all selected tricks
      List<TrickObstacleItem> _tricks = providerTrick.getSelectedTricks();
      // Choose random obsacle
      TrickObstacleItem _obstacle =
          _obstacles[Random().nextInt(_obstacles.length)];
      // Filter tricks that are possible on this obstalce
      List<TrickObstacleItem> _avaibleTricks =
          _getPossibleTricks(_tricks, _obstacle);
      //Choose random trick from available obstacle
      TrickObstacleItem _trick =
          _avaibleTricks[Random().nextInt(_avaibleTricks.length)];

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

      for (int i = diceTexts.length; i < 4; i++) {
        diceTexts.add("");
      }

      _dice1.state.animate(diceTexts[0]);
      Timer(Duration(milliseconds: 75), () {
        _dice2.state.animate(diceTexts[1]);
      });
      Timer(Duration(milliseconds: 150), () {
        _dice3.state.animate(diceTexts[2]);
      });
      Timer(Duration(milliseconds: 225), () {
        _dice4.state.animate(diceTexts[3]);
      });
    }

    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
              text: "Skate Dice",
              iconRight: Icons.settings,
              functionRight: _settingButtonPressed),
          SkateDices(_dice1, _dice2, _dice3, _dice4),
          SizedBox(height: MediaQuery.of(context).size.height / 100),
          Button(
              text: AppLocalizations.of(context).translate("roll_dice"),
              function: _rollDiceButtonPressed),
          Spacer(),
          _players(),
          Spacer(),
        ],
      ),
    );
  }

  _players() => Consumer<PlayerList>(builder: (context, players, child) {
        if (players.players.length == 0) {
          return Text(
            AppLocalizations.of(context).translate("no_players"),
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: MediaQuery.of(context).size.width / 25),
          );
        }

        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: players.players.length,
          itemBuilder: (BuildContext context, int index) =>
              SkateDicePlayer(name: players.players[index].name),
        );
      });
}

class SkateDices extends StatefulWidget {
  const SkateDices(this.dice1, this.dice2, this.dice3, this.dice4);

  final SkateDiceDice dice1, dice2, dice3, dice4;

  @override
  _SkateDicesState createState() => _SkateDicesState();
}

class _SkateDicesState extends State<SkateDices> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: MediaQuery.of(context).size.height / 100),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.dice1,
          widget.dice2,
        ],
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        widget.dice3,
        widget.dice4,
      ])
    ]);
  }
}
