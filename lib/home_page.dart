import 'package:flutter/material.dart';
import 'package:rollbrett_rottweil/reusable/rollbrett_logo.dart';

class HomePage extends StatelessWidget {
  _coursePreviewPressed() {}

  _skateDicePressed() {}

  _lcaleDealerPressed() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          HomePageTopBar(),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HomePageButton("Course Preview", Icons.accessible_forward_sharp,
                  _coursePreviewPressed),
              HomePageButton(
                  "Skate Dice", Icons.pest_control_rodent, _skateDicePressed),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DisabledHomePageButton(
                  "Course Preview", Icons.accessible_forward_sharp, null),
              HomePageButton(
                  "Skate Dice", Icons.pest_control_rodent, _skateDicePressed),
            ],
          ),
        ]),
      ),
    );
  }
}

class HomePageTopBar extends StatelessWidget {
  const HomePageTopBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: RollbrettLogo(LogoSize.medium)),
            LogoutButton()
          ],
        ),
        SizedBox(height: 15),
        Text(
          "Rollbrett Rottweil",
          style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: MediaQuery.of(context).size.width / 12,
              fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width -
          MediaQuery.of(context).size.width * 0.2,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              onPressed: () => {Navigator.of(context).pop()},
              child: Column(
                // Replace with a Row for horizontal icon + text
                children: <Widget>[
                  Icon(
                    Icons.power_settings_new,
                    color: Theme.of(context).accentColor,
                    size: MediaQuery.of(context).size.width * 0.08,
                  ),
                  Text(
                    "Logout",
                    style: TextStyle(color: Theme.of(context).accentColor),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePageButton extends StatelessWidget {
  const HomePageButton(this.text, this.icon, this.function);

  final String text;
  final IconData icon;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
        ),
        onPressed: function,
        child: Container(
          height: MediaQuery.of(context).size.height / 3.9,
          width: MediaQuery.of(context).size.width / 3,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).primaryColor,
                  size: MediaQuery.of(context).size.width / 4.5,
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20, color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DisabledHomePageButton extends StatelessWidget {
  const DisabledHomePageButton(this.text, this.icon, this.function);

  final String text;
  final IconData icon;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        HomePageButton(text, icon, function),
        Column(
          children: [
            Icon(Icons.lock, size: 50, color: Theme.of(context).accentColor,),
            Text(
              "Coming soon",
              style: TextStyle(
                fontSize: 22,
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ],
    );
  }
}
