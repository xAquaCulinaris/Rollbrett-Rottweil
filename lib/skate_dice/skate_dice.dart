import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rollbrett_rottweil/app_localizations.dart';
import 'package:rollbrett_rottweil/reusable/button.dart';
import 'package:rollbrett_rottweil/reusable/custom_app_bar.dart';
import 'package:rollbrett_rottweil/skate_dice/models/GenerateTrick.dart';
import 'package:rollbrett_rottweil/skate_dice/models/Player.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/providers/ObstacleProvider.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/providers/SettingProvider.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/providers/TrickProvider.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/widgets/nav_bar.dart';
import 'package:rollbrett_rottweil/skate_dice/widgets/skate_dice_place_holder.dart';
import 'package:rollbrett_rottweil/skate_dice/widgets/skate_dice_dice.dart';
import 'package:rollbrett_rottweil/skate_dice/widgets/skate_dice_player.dart';
import 'dart:async';

//dynamicly create skate dices
class SkateDice extends StatefulWidget {
  @override
  _SkateDiceState createState() => _SkateDiceState();
}

class _SkateDiceState extends State<SkateDice> {
  var settingProvider;

  // TODO currently default difficulty is easy and gets never changed
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      settingProvider = Provider.of<SettingsProvider>(context, listen: false);
      ObstacleProvider obstacleProvider =
          Provider.of<ObstacleProvider>(context, listen: false);
      TrickProvider trickProvider =
          Provider.of<TrickProvider>(context, listen: false);
      obstacleProvider.loadObstacles();
      trickProvider.loadTricks();
    });
  }

  @override
  Widget build(BuildContext context) {
    _settingButtonPressed() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NavBar(),
        ),
      );
    }

    void _updatDices(List<String> diceTexts) {
      int duration = 0;
      for (int i = 0; i < diceTexts.length; i++) {
        Timer(Duration(milliseconds: duration), () {
          SkateDiceDice dice =
              Provider.of<SettingsProvider>(context, listen: false).diceList[i];
          dice.state.animate(diceTexts[i]);
        });
        duration += 100;
      }
    }

    _rollDiceButtonPressed() {
      List<String> diceTexts =
          GenerateTrick.getInstace(context).generateTrick();

      if (diceTexts.isEmpty) {
        //TODO limit reroll to amount of tries 
        print("no possible tricks");
        int rerollTries = 0;
        while (diceTexts.isEmpty)
          diceTexts = GenerateTrick.getInstace(context).generateTrick();
        rerollTries++;
        print("reroll succeded after " + rerollTries.toString() + " tries");
        _updatDices(diceTexts);
      } else {_updatDices(diceTexts);}
    }

    

    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
              text: "Skate Dice",
              iconRight: Icons.settings,
              functionRight: _settingButtonPressed),
          _dices(),
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

  _dices() => Consumer<SettingsProvider>(builder: (context, dices, child) {
        return Column(children: [
          SizedBox(height: MediaQuery.of(context).size.height / 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              dices.diceList[0],
              dices.diceList[1],
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            dices.diceList.length >= 3
                ? dices.diceList[2]
                : SkateDicePlaceholder(),
            dices.diceList.length >= 4
                ? dices.diceList[3]
                : SkateDicePlaceholder(),
          ])
        ]);
      });
}
