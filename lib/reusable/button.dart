import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  const Button({
    Key key,
    this.text,
    this.function,
  }) : super(key: key);

  final String text;
  final Function function;

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.15,
      child: ElevatedButton(
        onPressed: widget.function,
        child: Text(widget.text, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800), textAlign: TextAlign.center,),
      ),
    );
  }
}
