import 'package:flutter/material.dart';

//TODO on name click disable all, on icon click expand
class CustomCheckboxHeader extends StatefulWidget {
  final provider;
  final headerIndex;
  const CustomCheckboxHeader(
      {Key key, @required this.headerIndex, @required this.provider})
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
    //final provider = Provider.of<ObstacleProvider>(context);
    final _allObstacleHeaders = widget.provider.items;
    return Column(
      children: [
        TextButton(
          onPressed: _textPressed,
          child: Row(
            children: [
              buildIcon(),
              Text(
                _allObstacleHeaders[widget.headerIndex].name,
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
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              itemCount: _allObstacleHeaders[widget.headerIndex].items.length,
              itemBuilder: (context, index) {
                return CustomCheckboxListItem(
                    widget.headerIndex, index, widget.provider);
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
  final provider;

  CustomCheckboxListItem(this.headerIndex, this.obstacleIndex, this.provider);

  @override
  _CustomCheckboxListItemState createState() => _CustomCheckboxListItemState();
}

class _CustomCheckboxListItemState extends State<CustomCheckboxListItem> {
  @override
  Widget build(BuildContext context) {
    final _allObstacleHeaders = widget.provider.items;
    return Padding(
      padding: const EdgeInsets.only(left: 32.0),
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              if (mounted)
                setState(() {
                  _allObstacleHeaders[widget.headerIndex]
                          .items[widget.obstacleIndex]
                          .checked =
                      !_allObstacleHeaders[widget.headerIndex]
                          .items[widget.obstacleIndex]
                          .checked;
                });
            },
            child: Text(
              _allObstacleHeaders[widget.headerIndex]
                  .items[widget.obstacleIndex]
                  .name,
              style: TextStyle(
                  color: _allObstacleHeaders[widget.headerIndex]
                          .items[widget.obstacleIndex]
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
