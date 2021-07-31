import 'package:flutter/material.dart';

class CustomTextBox extends StatefulWidget {
  CustomTextBox({
    Key key,
    this.labelText,
    this.icon,
    this.setText,
    this.textInputType,
    this.isPassword = false
  }) : super(key: key);

  final String labelText;
  final IconData icon;
  final Function setText;
  final TextInputType textInputType;
  final bool isPassword;

  @override
  _TextBoxState createState() => _TextBoxState();
}

class _TextBoxState extends State<CustomTextBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: TextFormField(
        style: TextStyle(color: Theme.of(context).primaryColor),
        keyboardType: widget.textInputType,
        obscureText: widget.isPassword,
        onChanged: (value) {
          setState(() {
            widget.setText(value);
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon, color: Theme.of(context).primaryColor,),
          labelText: widget.labelText,
          labelStyle: TextStyle(color: Theme.of(context).primaryColor),
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
