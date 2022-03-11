import 'package:flutter/material.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/providers/SettingProvider.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/widgets/DifficultySettingsItems/DifficultyItem.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice_config/widgets/DifficultySettingsItems/DifficultyItemHeader.dart';

class DifficultyWidget extends StatefulWidget {
  const DifficultyWidget(this.header, this.updateFunction);

  final DifficultyItemHeader header;
  final Function updateFunction;

  @override
  State<DifficultyWidget> createState() => _DifficultyWidgetState();
}

class _DifficultyWidgetState extends State<DifficultyWidget> {
  _textPressed() {
    if (mounted) {
      setState(() {
        widget.header.expanded = !widget.header.expanded;
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
            Text(widget.header.name,
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: MediaQuery.of(context).size.height / 25)),
          ],
        ),
      ),
      if (widget.header.expanded)
        //Change
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(0),
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              return EnumListItem(
                  widget.header.items[index], updateCurrentSelection);
            })
    ]);
  }

  void updateCurrentSelection(String name) {
    if (name == "Easy") {
      if (mounted)
        setState(() {
          widget.updateFunction(Difficulty.Easy);
        });
    } else if (name == "Medium") {
      if (mounted)
        setState(() {
          widget.updateFunction(Difficulty.Medium);
          ;
        });
    } else if (name == "Hard") {
      if (mounted)
        setState(() {
          widget.updateFunction(Difficulty.Hard);
        });
    }
  }

  Widget buildIcon() {
    return widget.header.expanded
        ? Icon(Icons.arrow_drop_down, color: Theme.of(context).accentColor)
        : Icon(Icons.arrow_right, color: Theme.of(context).accentColor);
  }
}

class EnumListItem extends StatefulWidget {
  const EnumListItem(this.enumItem, this.updateFunction);

  final DifficultyItem enumItem;
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
              widget.updateFunction(widget.enumItem.name);
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
