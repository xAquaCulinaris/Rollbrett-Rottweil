import 'package:flutter/material.dart';

class CustomTextBox extends StatefulWidget {
  CustomTextBox(
      {Key key,
      @required this.labelText,
      @required this.icon,
      @required this.setText,
      @required this.textInputType,
      this.isPassword = false,
      this.initialText})
      : super(key: key);

  final String labelText;
  final IconData icon;
  final Function setText;
  final TextInputType textInputType;
  final bool isPassword;
  final String initialText;

  @override
  _TextBoxState createState() => _TextBoxState();
}

class _TextBoxState extends State<CustomTextBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: TextFormField(
        initialValue: widget.initialText,
        style: TextStyle(color: Theme.of(context).primaryColor),
        keyboardType: widget.textInputType,
        obscureText: widget.isPassword,
        onChanged: (value) {
          setState(() {
            widget.setText(value);
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            widget.icon,
            color: Theme.of(context).primaryColor,
          ),
          hintText: widget.labelText,
          hintStyle: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w700),
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
    );
  }
}
