import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rollbrett_rottweil/app_localizations.dart';
import 'package:rollbrett_rottweil/reusable/button.dart';
import 'package:rollbrett_rottweil/reusable/custom_app_bar.dart';
import 'package:rollbrett_rottweil/skate_dice/models/Item.dart';
import 'package:rollbrett_rottweil/skate_dice/provider/ObstacleProvider.dart';
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

  @override
  Widget build(BuildContext context) {
    final providerObstacle = Provider.of<ObstacleProvider>(context);
    final providerTrick = Provider.of<TrickProvider>(context);
    //TODO remove only for testing
    int counter = 0;

    _settingButtonPressed() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NavBar(),
        ),
      );
    }

    _rollDiceButtonPressed() {
      List<Item> _obstacles = providerObstacle.getSelectedObstacles();
      List<Item> _tricks = providerTrick.getSelectedTricks();

      for (Item obstacle in _obstacles) {
        print(obstacle.name);
      }

      for (Item trick in _tricks) {
        print(trick.name);
      }

      //TODO replace only for testing
      if (counter == 0) {
        _dice1.state.animate("FRONT SIDE");
        Timer(Duration(milliseconds: 100), () {
          _dice2.state.animate("NOSE GRIND");
        });
        Timer(Duration(milliseconds: 200), () {
          _dice3.state.animate("SHUVIT OUT");
        });
        Timer(Duration(milliseconds: 300), () {
          _dice4.state.animate("");
        });
      }

      if (counter == 1) {
        _dice1.state.animate("BACK SIDE");
        Timer(Duration(milliseconds: 100), () {
          _dice2.state.animate("50-50");
        });
        Timer(Duration(milliseconds: 200), () {
          _dice3.state.animate("KICKFLIP OUT");
        });
        Timer(Duration(milliseconds: 300), () {
          _dice4.state.animate("");
        });
      }

      if (counter == 2) {
        _dice1.state.animate("NOSESLIDE");
        Timer(Duration(milliseconds: 100), () {
          _dice2.state.animate("HUBBA");
        });
        Timer(Duration(milliseconds: 200), () {
          _dice3.state.animate("SHUVIT OUT");
        });
        Timer(Duration(milliseconds: 300), () {
          _dice4.state.animate("");
        });
      }

      counter++;
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
