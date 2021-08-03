import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({Key key, this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(text == null ? "" : text,
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.06)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
