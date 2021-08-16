import 'package:flutter/material.dart';

class CustomRadioButtonHeader extends StatefulWidget {
  final String text;
  final List<String> items;
  final Function getter;
  final Function setter;

  const CustomRadioButtonHeader(
      this.text, this.items, this.getter, this.setter);

  @override
  _CustomRadioButtonHeaderState createState() =>
      _CustomRadioButtonHeaderState();
}

class _CustomRadioButtonHeaderState extends State<CustomRadioButtonHeader> {
  bool expanded = false;

  _textPressed() {
    print("widget: " + widget.getter().toString());
    if (mounted) {
      setState(() {
        expanded = !expanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: _textPressed,
          child: Row(
            children: [
              buildIcon(),
              Text(
                widget.text,
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: MediaQuery.of(context).size.height / 25,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        if (expanded)
          //Change
          CustomRadioButton(widget.getter, widget.setter)
      ],
    );
  }

  Widget buildIcon() {
    return expanded
        ? Icon(Icons.arrow_drop_down, color: Theme.of(context).accentColor)
        : Icon(Icons.arrow_right, color: Theme.of(context).accentColor);
  }
}

class CustomRadioButton extends StatefulWidget {
  final Function get;
  final Function set;
  const CustomRadioButton(this.get, this.set);

  @override
  _CustomRadioButtonState createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: TextButton(
              onPressed: () {
                if (mounted) {
                  setState(() {
                    widget.set(true);
                  });
                }
              },
              child: Text(
                "Yes",
                style: TextStyle(
                    color: widget.get() == true
                        ? Theme.of(context).accentColor
                        : Theme.of(context).disabledColor,
                    fontSize: MediaQuery.of(context).size.height / 25),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: TextButton(
              onPressed: () {
                if (mounted) {
                  setState(() {
                    widget.set(false);
                  });
                }
              },
              child: Text(
                "No",
                style: TextStyle(
                    color: widget.get() == false
                        ? Theme.of(context).accentColor
                        : Theme.of(context).disabledColor,
                    fontSize: MediaQuery.of(context).size.height / 25),
              ),
            ),
          )
        ],
      ),
    );
  }
}
