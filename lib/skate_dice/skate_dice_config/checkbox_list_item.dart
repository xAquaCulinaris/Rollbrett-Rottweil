import 'package:flutter/material.dart';

class CustomCheckboxListItem extends StatefulWidget {
  final String name;
  bool checked;

  CustomCheckboxListItem(this.name, this.checked);

  @override
  _CustomCheckboxListItemState createState() => _CustomCheckboxListItemState();
}

class _CustomCheckboxListItemState extends State<CustomCheckboxListItem> {
  _itemPressed() {
    if (mounted)
      setState(() {
        widget.checked = !widget.checked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 2),
      child: TextButton(
        onPressed: _itemPressed,
        child: Text(
          widget.name,
          style: TextStyle(
              color:
                  widget.checked ? Theme.of(context).accentColor : Colors.red,
              fontSize: MediaQuery.of(context).size.height / 40),
        ),
      ),
    );
  }
}

class CustomCheckboxHeader extends StatefulWidget {
  final List<CustomCheckboxListItem> items;
  final String name;
  const CustomCheckboxHeader({Key key, @required this.name, this.items})
      : super(key: key);

  @override
  _CustomCheckboxHeaderState createState() => _CustomCheckboxHeaderState();
}

class _CustomCheckboxHeaderState extends State<CustomCheckboxHeader> {
  bool expanded = false;

  _textPressed() {
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
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8),
          child: TextButton(
            onPressed: _textPressed,
            child: Row(
              children: [
                buildIcon(),
                Text(widget.name,
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: MediaQuery.of(context).size.height / 25)),
              ],
            ),
          ),
        ),
        if (expanded)
          Expanded(
            child: ListView(
              children: widget.items,
            ),
          )
      ],
    );
  }

  Widget buildIcon() {
    return expanded
        ? Icon(Icons.arrow_drop_down, color: Theme.of(context).accentColor)
        : Icon(Icons.arrow_right, color: Theme.of(context).accentColor);
  }
}
