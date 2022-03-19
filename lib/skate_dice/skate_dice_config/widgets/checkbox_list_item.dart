import 'package:flutter/material.dart';

class CustomCheckboxHeader extends StatefulWidget {
  //final provider;
  final allObstacleHeaders;
  final headerIndex;
  final bool selectOnlyOne;
  final Function updateFunction;
  const CustomCheckboxHeader(
      {Key key,
      @required this.headerIndex,
      @required this.allObstacleHeaders,
      @required this.updateFunction,
      this.selectOnlyOne = false})
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
    final _allObstacleHeaders = widget.allObstacleHeaders;
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
              itemCount: _allObstacleHeaders[widget.headerIndex].items.length,
              itemBuilder: (context, index) {
                return CustomCheckboxListItem(
                    headerIndex: widget.headerIndex,
                    obstacleIndex: index,
                    allObstacleHeaders: widget.allObstacleHeaders,
                    updateFunction: widget.updateFunction,
                    selectOnlyOne: widget.selectOnlyOne);
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
  final bool selectOnlyOne;
   final Function updateFunction;
  final allObstacleHeaders;

  const CustomCheckboxListItem(
      {Key key,
      @required this.headerIndex,
      @required this.obstacleIndex,
      @required this.allObstacleHeaders,
      @required this.updateFunction,
      this.selectOnlyOne})
      : super(key: key);

  @override
  _CustomCheckboxListItemState createState() => _CustomCheckboxListItemState();
}

class _CustomCheckboxListItemState extends State<CustomCheckboxListItem> {
  @override
  Widget build(BuildContext context) {
    final _allObstacleHeaders = widget.allObstacleHeaders;
    return Padding(
      padding: const EdgeInsets.only(left: 32.0),
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              widget.updateFunction(_allObstacleHeaders, widget.headerIndex, widget.obstacleIndex);
            },
            child: Text(
              "    " + _allObstacleHeaders[widget.headerIndex]
                  .items[widget.obstacleIndex]
                  .name,
              style: TextStyle(
                  color: _allObstacleHeaders[widget.headerIndex]
                          .items[widget.obstacleIndex]
                          .checked
                      ? Theme.of(context).accentColor
                      : Theme.of(context).disabledColor,
                  fontSize: MediaQuery.of(context).size.height / 30),
            ),
          ),
          Spacer()
        ],
      ),
    );
  }

/*
//TODO investigate why not updated
  void updateChecks(List<ItemHeader> _allObstacleHeaders) {
    if (!widget.selectOnlyOne) {
      if (mounted)
        setState(() {
          _allObstacleHeaders[widget.headerIndex]
                  .items[widget.obstacleIndex]
                  .checked =
              !_allObstacleHeaders[widget.headerIndex]
                  .items[widget.obstacleIndex]
                  .checked;
        });
    } else {
      for (int i = 0;
          i < _allObstacleHeaders[widget.headerIndex].items.length;
          i++) {
        if (mounted)
          setState(() {
            _allObstacleHeaders[widget.headerIndex].items[i].checked = false;
          });
      }
      if (mounted)
        setState(() {
          _allObstacleHeaders[widget.headerIndex]
              .items[widget.obstacleIndex]
              .checked = true;
        });
    }
  }*/
}
