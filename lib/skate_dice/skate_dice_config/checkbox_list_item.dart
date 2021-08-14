import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rollbrett_rottweil/skate_dice/models/ObstacleProvider.dart';

class CustomCheckboxHeader extends StatefulWidget {
  final headerIndex;
  const CustomCheckboxHeader({Key key, @required this.headerIndex})
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
    final provider = Provider.of<ObstacleProvider>(context);
    final _allObstacleHeaders = provider.obstacles;
    return Column(
      children: [
        TextButton(
          onPressed: _textPressed,
          child: Row(
            children: [
              buildIcon(),
              Text(_allObstacleHeaders[widget.headerIndex].name,
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
              itemCount:
                  _allObstacleHeaders[widget.headerIndex].obstacles.length,
              itemBuilder: (context, index) {
                return CustomCheckboxListItem(widget.headerIndex, index);
              })
      ],
    );
  }

  Widget buildIcon() {
    return expanded
        ? Icon(Icons.arrow_drop_down, color: Theme.of(context).accentColor)
        : Icon(Icons.arrow_right, color: Theme.of(context).accentColor);
  }
}

class CustomCheckboxListItem extends StatefulWidget {
  final int headerIndex;
  final int obstacleIndex;

  CustomCheckboxListItem(this.headerIndex, this.obstacleIndex);

  @override
  _CustomCheckboxListItemState createState() => _CustomCheckboxListItemState();
}

class _CustomCheckboxListItemState extends State<CustomCheckboxListItem> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ObstacleProvider>(context);
    final _allObstacleHeaders = provider.obstacles;
    return Padding(
      padding: const EdgeInsets.only(left: 32.0),
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              if (mounted)
                setState(() {
                  _allObstacleHeaders[widget.headerIndex]
                          .obstacles[widget.obstacleIndex]
                          .checked =
                      !_allObstacleHeaders[widget.headerIndex]
                          .obstacles[widget.obstacleIndex]
                          .checked;
                });
            },
            child: Text(
              _allObstacleHeaders[widget.headerIndex]
                  .obstacles[widget.obstacleIndex]
                  .name,
              style: TextStyle(
                  color: _allObstacleHeaders[widget.headerIndex]
                          .obstacles[widget.obstacleIndex]
                          .checked
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
