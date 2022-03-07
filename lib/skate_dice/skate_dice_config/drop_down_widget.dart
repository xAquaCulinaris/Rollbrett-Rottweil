import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rollbrett_rottweil/skate_dice/models/EnumSettingItem/EnumItem.dart';
import 'package:rollbrett_rottweil/skate_dice/models/EnumSettingItem/EnumItemHeader.dart';
import 'package:rollbrett_rottweil/skate_dice/provider/DiceList.dart';
import 'package:rollbrett_rottweil/skate_dice/provider/SettingProvider.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget(this.enumItemHeader);

  final EnumItemHeader enumItemHeader;

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
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
    return Column(children: [
      TextButton(
        onPressed: _textPressed,
        child: Row(
          children: [
            buildIcon(),
            Text("Difficulty",
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: MediaQuery.of(context).size.height / 25)),
          ],
        ),
      ),
      if (expanded)
        //Change
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(0),
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              return EnumListItem(
                  widget.enumItemHeader.items[index], updateCurrentSelection);
            })
    ]);
  }

  void updateCurrentSelection(String name, BuildContext context) {
    if (name == "Easy") {
      Provider.of<DiceList>(context, listen: false)
          .updateDifficulty(Difficulty.Easy);
      if (mounted)
        setState(() {
          widget.enumItemHeader.items[0].checked = true;
          widget.enumItemHeader.items[1].checked = false;
          widget.enumItemHeader.items[2].checked = false;
        });
    } else if (name == "Medium") {
      Provider.of<DiceList>(context, listen: false)
          .updateDifficulty(Difficulty.Medium);
      if (mounted)
        setState(() {
          widget.enumItemHeader.items[0].checked = false;
          widget.enumItemHeader.items[1].checked = true;
          widget.enumItemHeader.items[2].checked = false;
        });
    } else if (name == "Hard") {
      Provider.of<DiceList>(context, listen: false)
          .updateDifficulty(Difficulty.Hard);
      if (mounted)
        setState(() {
          widget.enumItemHeader.items[0].checked = false;
          widget.enumItemHeader.items[1].checked = false;
          widget.enumItemHeader.items[2].checked = true;
        });
    }
  }

  Widget buildIcon() {
    return expanded
        ? Icon(Icons.arrow_drop_down, color: Theme.of(context).accentColor)
        : Icon(Icons.arrow_right, color: Theme.of(context).accentColor);
  }
}

class EnumListItem extends StatefulWidget {
  const EnumListItem(this.enumItem, this.updateFunction);

  final EnumItem enumItem;
  final Function updateFunction;

  @override
  State<EnumListItem> createState() => _EnumListItemState();
}

class _EnumListItemState extends State<EnumListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0),
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              widget.updateFunction(widget.enumItem.name, context);
            },
            child: Text(
              widget.enumItem.name,
              style: TextStyle(
                  color: widget.enumItem.checked
                      ? Theme.of(context).accentColor
                      : Theme.of(context).disabledColor,
                  fontSize: MediaQuery.of(context).size.height / 25),
            ),
          ),
          Spacer()
        ],
      ),
    );
  }
}
