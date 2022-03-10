import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  final String title;
  final String description;
  final String firstButtonText;
  final String secondButtonText;
  final Function firstButtonCallback;
  final Function secondButtonCallback;

  const CustomDialog(
      {Key key,
      this.title,
      this.description,
      this.firstButtonText,
      this.secondButtonText,
      this.firstButtonCallback,
      this.secondButtonCallback});

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: ContentBox(
          context,
          widget.title,
          widget.description,
          widget.firstButtonText,
          widget.secondButtonText,
          widget.firstButtonCallback,
          widget.secondButtonCallback),
    );
  }
}

class ContentBox extends StatelessWidget {
  ContentBox(
      this.context,
      this.title,
      this.description,
      this.firstButtonText,
      this.secondButtonText,
      this.firstButtonCallback,
      this.secondButtonCallback);

  final BuildContext context;
  final String title;
  final String description;
  final String firstButtonText;
  final String secondButtonText;
  final Function firstButtonCallback;
  final Function secondButtonCallback;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20, top: 65, right: 20, bottom: 20),
          margin: EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor)),
              SizedBox(height: 17),
              Text(description,
                  style: TextStyle(
                      fontSize: 14, color: Theme.of(context).primaryColor),
                  textAlign: TextAlign.center),
              SizedBox(height: 22),
              Align(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    if (secondButtonText == null) Spacer(),
                    FlatButton(
                      onPressed: () {
                        if (firstButtonCallback == null) {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        } else {
                          firstButtonCallback();
                        }
                      },
                      child: Text(
                        firstButtonText,
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    Spacer(),
                    if (secondButtonText != null)
                      FlatButton(
                        onPressed: () {
                          if (secondButtonCallback == null) {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          } else {
                            secondButtonCallback();
                          }
                        },
                        child: Text(
                          secondButtonText,
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
            left: 20,
            right: 20,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 45,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(45)),
                child: Image.asset(
                  "assets/images/rollbrett_rottweil.jpg",
                ),
              ),
            ))
      ],
    );
  }
}
