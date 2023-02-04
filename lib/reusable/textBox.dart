import 'package:flutter/material.dart';

class CustomTextBox extends StatefulWidget {
  CustomTextBox(
      {Key key,
      @required this.labelText,
      @required this.icon,
      @required this.setText,
      @required this.textInputType,
      this.isPassword = false,
      this.initialText,
      this.suffixIcon,
      this.suffixFunction,
      this.controller,
      this.startWithCapitalLetter = false})
      : super(key: key);

  final String labelText;
  final IconData icon;
  final Function setText;
  final TextInputType textInputType;
  final bool isPassword;
  final String initialText;
  final IconData suffixIcon;
  final Function suffixFunction;
  final TextEditingController controller;
  final bool startWithCapitalLetter;

  @override
  _TextBoxState createState() => _TextBoxState();
}

class _TextBoxState extends State<CustomTextBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: TextFormField(
        textCapitalization: widget.startWithCapitalLetter ? TextCapitalization.sentences : TextCapitalization.none,
        //when suffix fuction is set, on enter press on keyboard function is called
        onFieldSubmitted: (value) {
          if (widget.suffixFunction != null) widget.suffixFunction();
        },
        controller: widget.controller,
        initialValue: widget.initialText,
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.width / 20),
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
          suffixIcon: widget.suffixIcon == null
              ? null
              : IconButton(
                  icon: Icon(
                    widget.suffixIcon,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: widget.suffixFunction,
                ),
          hintText: widget.labelText,
          hintStyle: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w700),
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
