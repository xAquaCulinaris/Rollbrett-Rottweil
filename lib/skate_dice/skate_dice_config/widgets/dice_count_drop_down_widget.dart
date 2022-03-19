import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/providers/SettingProvider.dart';

class DiceCountDropDown extends StatefulWidget {
  const DiceCountDropDown() : super();

  @override
  State<DiceCountDropDown> createState() => _DiceCountDropDownState();
}

class _DiceCountDropDownState extends State<DiceCountDropDown> {
  List<String> items = ['2', '3', '4', "Random"];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Text("Dice count: ",
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: MediaQuery.of(context).size.height / 25)),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: Provider.of<SettingsProvider>(context, listen: false)
                      .randomActivated
                  ? "Random"
                  : Provider.of<SettingsProvider>(context, listen: false)
                      .currentDiceCount,
              icon: Icon(Icons.arrow_drop_down,
                  color: Theme.of(context).accentColor),
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: MediaQuery.of(context).size.height / 25),
              onChanged: (newValue) {
                setState(() {
                  Provider.of<SettingsProvider>(context, listen: false)
                      .updateGameDifficulty(newValue);
                });
              },
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
