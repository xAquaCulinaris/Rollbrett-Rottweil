import 'package:flutter/material.dart';

//TODO adjust textsize acording to text.length
class CustomAppBar extends StatelessWidget {
  CustomAppBar({Key key, this.text, this.iconRight, this.functionRight});
  final String text;
  final IconData iconRight;
  final Function functionRight;

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
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.09,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).accentColor)),
              ),
              iconRight != null
                  ? Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          icon: Icon(iconRight,
                              color: Theme.of(context).accentColor),
                          onPressed: functionRight),
                    )
                  : SizedBox()
            ],
          )
        ],
      ),
    );
  }
}
