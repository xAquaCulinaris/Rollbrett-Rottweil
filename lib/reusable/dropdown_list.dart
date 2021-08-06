import 'package:flutter/material.dart';

class DropDownList extends StatefulWidget {
  DropDownList(
      {Key key,
      @required this.itemList,
      @required this.icon,
      @required this.setDropDownValue})
      : super(key: key);

  final List<String> itemList;
  final IconData icon;
  final Function setDropDownValue;

  @override
  _DropDownListState createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  @override
  void initState() {
    selectedItem = widget.itemList.first;
    widget.setDropDownValue(selectedItem);
    super.initState();
  }

  String selectedItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Theme(
        data: Theme.of(context)
            .copyWith(canvasColor: Theme.of(context).accentColor),
        child: DropdownButtonFormField<String>(
          items: widget.itemList.map((text) {
            return DropdownMenuItem(
              child: Text(text),
              value: text,
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedItem = value;
            });
            widget.setDropDownValue(selectedItem);
            print("selectedItem: " + selectedItem);
          },
          value: selectedItem,
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w700),
          dropdownColor: Theme.of(context).accentColor,
          icon: Icon(
            // Add this
            Icons.arrow_drop_down, // Add this
            color: Theme.of(context).primaryColor, // Add this
          ),
          decoration: InputDecoration(
            prefixIcon:
                Icon(widget.icon, color: Theme.of(context).primaryColor),
            //labelText: widget.labelText,
            //labelStyle: TextStyle(color: Theme.of(context).primaryColor),
            filled: true,
            fillColor: Theme.of(context).accentColor,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
