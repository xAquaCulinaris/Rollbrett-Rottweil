import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rollbrett_rottweil/app_localizations.dart';
import 'package:rollbrett_rottweil/reusable/custom_dialog.dart';
import 'package:rollbrett_rottweil/skate_dice_new/Providers/player_list.dart';
import 'package:rollbrett_rottweil/skate_dice_new/models/player.dart';

class SkateDicePlayer extends StatefulWidget {
  const SkateDicePlayer({Key key, this.player}) : super(key: key);
  final Player player;

  @override
  _SkateDicePlayerState createState() => _SkateDicePlayerState();
}

class _SkateDicePlayerState extends State<SkateDicePlayer> {
  static const Set<String> _skate = {'S', 'K', 'A', 'T', 'E'};

  _addLetter() {
    setState(() {
      if (widget.player.letters < 5) widget.player.letters++;
    });

    String winnerName =
        Provider.of<PlayerList>(context, listen: false).getWinnerName();
    if (winnerName != null) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialog(
              title: AppLocalizations.of(context).translate('restart_game'),
              description: winnerName +
                  AppLocalizations.of(context).translate('winner_game_text'),
              firstButtonText: "Okay",
              secondButtonText:
                  AppLocalizations.of(context).translate('restart'),
              firstButtonCallback: () => Navigator.pop(context),
              secondButtonCallback: () {
                Provider.of<PlayerList>(context, listen: false).restartGame();
                Navigator.pop(context);
              },
            );
          });
    }
  }

  _removeLetter() {
    setState(() {
      if (widget.player.letters > 0) widget.player.letters--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: MediaQuery.of(context).size.width / 30),
        SizedBox(
          width: MediaQuery.of(context).size.width / 3.5,
          //FitteBox scales down text if to big
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              widget.player.name,
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: MediaQuery.of(context).size.height / 25,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
        IconButton(
            icon: Icon(Icons.remove, color: Theme.of(context).accentColor),
            onPressed: _removeLetter),
        for (var i = 0; i < 5; i++)
          widget.player.letters > i
              ? LetterItem(
                  letter: _skate.elementAt(i),
                )
              : LetterPlaceholder(),
        IconButton(
            icon: Icon(Icons.add, color: Theme.of(context).accentColor),
            onPressed: _addLetter),
        Spacer()
      ],
    );
  }
}

class LetterPlaceholder extends StatefulWidget {
  const LetterPlaceholder({Key key}) : super(key: key);

  @override
  _LetterPlaceholderState createState() => _LetterPlaceholderState();
}

class _LetterPlaceholderState extends State<LetterPlaceholder>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: ScaleTransition(
        scale: _controller,
        child: Container(
          height: MediaQuery.of(context).size.width / 13,
          width: MediaQuery.of(context).size.width / 15,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).accentColor),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
        ),
      ),
    );
  }
}

class LetterItem extends StatefulWidget {
  const LetterItem({Key key, this.letter}) : super(key: key);
  final String letter;

  @override
  _LetterItemState createState() => _LetterItemState();
}

class _LetterItemState extends State<LetterItem>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: ScaleTransition(
        scale: _controller,
        child: Container(
          height: MediaQuery.of(context).size.width / 13,
          width: MediaQuery.of(context).size.width / 15,
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.all(Radius.circular(4))),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              widget.letter,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w900,
                  fontSize: MediaQuery.of(context).size.height / 30),
            ),
          ),
        ),
      ),
    );
  }
}
