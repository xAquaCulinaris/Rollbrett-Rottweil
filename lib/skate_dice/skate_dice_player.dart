import 'package:flutter/material.dart';

class SkateDicePlayer extends StatefulWidget {
  const SkateDicePlayer({Key key, this.name}) : super(key: key);
  final String name;

  @override
  _SkateDicePlayerState createState() => _SkateDicePlayerState();
}

class _SkateDicePlayerState extends State<SkateDicePlayer> {
  int _letterCounter = 0;
  static const Set<String> _skate = {'S', 'K', 'A', 'T', 'E'};

  _addLetter() {
    setState(() {
      if (_letterCounter < 5) _letterCounter++;
    });
  }

  _removeLetter() {
    setState(() {
      if (_letterCounter > 0) _letterCounter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: MediaQuery.of(context).size.width / 30),
        Text(
          widget.name,
          style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: MediaQuery.of(context).size.height / 25,
              fontWeight: FontWeight.w700),
        ),
        Spacer(),
        //TODO get custom bold icons
        IconButton(
            icon: Icon(Icons.remove, color: Theme.of(context).accentColor),
            onPressed: _removeLetter),

        for (var i = 0; i < 5; i++)
          _letterCounter > i
              ? LetterItem(
                  letter: _skate.elementAt(i),
                )
              : LetterPlaceholder(),

        IconButton(
            icon: Icon(Icons.add, color: Theme.of(context).accentColor),
            onPressed: _addLetter),
      ],
    );
  }
}

class LetterPlaceholder extends StatelessWidget {
  const LetterPlaceholder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        height: MediaQuery.of(context).size.width / 13,
        width: MediaQuery.of(context).size.width / 15,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).accentColor),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
    );
  }
}

class LetterItem extends StatelessWidget {
  const LetterItem({Key key, this.letter}) : super(key: key);
  final String letter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        height: MediaQuery.of(context).size.width / 13,
        width: MediaQuery.of(context).size.width / 15,
        decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            letter,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w900,
                fontSize: MediaQuery.of(context).size.height / 30),
          ),
        ),
      ),
    );
  }
}
