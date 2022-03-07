import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rollbrett_rottweil/app_localizations.dart';
import 'package:rollbrett_rottweil/reusable/button.dart';
import 'package:rollbrett_rottweil/reusable/custom_app_bar.dart';
import 'package:rollbrett_rottweil/skate_dice/models/GenerateTrick.dart';
import 'package:rollbrett_rottweil/skate_dice/models/Player.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/nav_bar.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/skate_dice_place_holder.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_dice.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_player.dart';
import 'dart:async';

import 'provider/DiceList.dart';
import 'provider/SettingProvider.dart';

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

    _rollDiceButtonPressed() {
      //TODO check why at first press no tricks available
      List<String> diceTexts =
          GenerateTrick.getInstace(context).generateTrick();

      if (diceTexts.isEmpty)
        //TODO show error message
        print("no possible tricks");
      else {
        int duration = 0;
        for (int i = 0; i < diceTexts.length; i++) {
          Timer(Duration(milliseconds: duration), () {
            SkateDiceDice dice =
                Provider.of<DiceList>(context, listen: false).diceList[i];
            dice.state.animate(diceTexts[i]);
          });
          duration += 100;
        }
      }
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

  _dices() => Consumer<DiceList>(builder: (context, dices, child) {
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
