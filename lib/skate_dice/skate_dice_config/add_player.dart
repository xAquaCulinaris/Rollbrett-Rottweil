import 'package:flutter/material.dart';
import 'package:rollbrett_rottweil/app_localizations.dart';
import 'package:rollbrett_rottweil/reusable/button.dart';
import 'package:rollbrett_rottweil/reusable/custom_app_bar.dart';
import 'package:rollbrett_rottweil/reusable/textBox.dart';
import 'package:rollbrett_rottweil/skate_dice/models/Player.dart';
import 'package:provider/provider.dart';

class AddPlayer extends StatefulWidget {
  const AddPlayer({Key key}) : super(key: key);

  @override
  _AddPlayerState createState() => _AddPlayerState();
}

class _AddPlayerState extends State<AddPlayer> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    String _name;
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
      }
    }

    return Scaffold(
      body: Column(
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
        ],
      ),
    );
  }

  _players() => Consumer<PlayerList>(builder: (context, players, child) {
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: players.players.length,
          itemBuilder: (BuildContext context, int index) =>
              PlayerItem(players.players[index].name),
        );
      });
}

class PlayerItem extends StatelessWidget {
  const PlayerItem(this.name);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Container(
            height: MediaQuery.of(context).size.width / 8,
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
                  onPressed: () {
                    Provider.of<PlayerList>(context, listen: false)
                        .removePlayer(name);
                  },
                )
              ],
            )),
      ),
    );
  }
}
