import 'package:flutter/material.dart';
import 'package:rollbrett_rottweil/app_localizations.dart';
import 'package:rollbrett_rottweil/reusable/button.dart';
import 'package:rollbrett_rottweil/reusable/custom_app_bar.dart';
import 'package:rollbrett_rottweil/reusable/custom_dialog.dart';
import 'package:rollbrett_rottweil/reusable/textBox.dart';
import 'package:rollbrett_rottweil/skate_dice/models/Player.dart';
import 'package:provider/provider.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/providers/SettingProvider.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/widgets/DifficultySettingsItems/DifficultyItem.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/widgets/DifficultySettingsItems/DifficultyItemHeader.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/widgets/dice_count_drop_down_widget.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/widgets/difficulty_widget.dart';

class AddPlayer extends StatefulWidget {
  const AddPlayer({Key key}) : super(key: key);

  @override
  _AddPlayerState createState() => _AddPlayerState();
}

class _AddPlayerState extends State<AddPlayer> {
  int index = 0;
  final key = GlobalKey<AnimatedListState>();
  TextEditingController _controller = TextEditingController();
  //TODO name max 6 letters or it will be to big on skate dice screen
  String _name = "";

  //Trick difficulty
  DifficultyItemHeader difficultyTrick =
      DifficultyItemHeader("Trick Difficulty", [
    DifficultyItem("Easy", true),
    DifficultyItem("Medium", false),
    DifficultyItem("Hard", false)
  ]);

  removeItem(int index) {
    String name =
        Provider.of<PlayerList>(context, listen: false).removePlayer(index);
    key.currentState.removeItem(
        index,
        (context, animation) =>
            PlayerItem(name, animation, () => removeItem(index)));
  }

  setName(String text) {
    _name = text;
  }

  _addButtonPressed() {
    if (_name != "") {
      Provider.of<PlayerList>(context, listen: false).addPlayer(_name);
      if (mounted)
        setState(() {
          _controller.clear();
          _name = "";
        });
      key.currentState.insertItem(
          Provider.of<PlayerList>(context, listen: false).players.length - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAppBar(
              text: AppLocalizations.of(context).translate("add_player")),
          SizedBox(height: MediaQuery.of(context).size.width / 15),
          CustomTextBox(
            labelText: AppLocalizations.of(context).translate("add_player"),
            icon: Icons.person_add,
            setText: setName,
            textInputType: TextInputType.name,
            suffixIcon: Icons.add,
            suffixFunction: _addButtonPressed,
            controller: _controller,
          ),
          _players(),
          _settings(),
          _restart()
        ],
      ),
    );
  }

  _players() {
    return Consumer<PlayerList>(builder: (context, players, child) {
      return AnimatedList(
        key: key,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        initialItemCount: players.players.length,
        itemBuilder: (context, index, animation) => PlayerItem(
            players.players[index].name, animation, () => removeItem(index)),
      );
    });
  }

  _settings() {
    return Padding(
      padding: const EdgeInsets.only(top: 64),
      child: Column(
        children: [
          DiceCountDropDown(),
          DifficultyWidget(
              Provider.of<SettingsProvider>(context, listen: false)
                  .trickDifficultyHeader,
              Provider.of<SettingsProvider>(context, listen: false)
                  .updateTrickDifficulty),
         
        ],
      ),
    );
  }

  _restart() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Button(
          text: AppLocalizations.of(context).translate('restart'),
          function: () => _restartFunction()),
    );
  }

  _restartFunction() {
    Provider.of<PlayerList>(context, listen: false).restartGame();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            title: AppLocalizations.of(context).translate('restart_game'),
            description:
                AppLocalizations.of(context).translate('restart_game_message'),
            firstButtonText: "Okay",
          );
        });
  }
}

class PlayerItem extends StatelessWidget {
  const PlayerItem(this.name, this.animation, this.removeFunction);
  final String name;
  final Animation animation;
  final Function removeFunction;

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: animation,
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(left: 32, right: 32, top: 16),
          child: Container(
              height: MediaQuery.of(context).size.width / 6,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Theme.of(context).accentColor),
              child: Row(
                children: [
                  Spacer(),
                  Text(name,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width / 12)),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.remove,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: removeFunction,
                  )
                ],
              )),
        ),
      ),
    );
  }
}
