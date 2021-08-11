import 'package:flutter/material.dart';
import 'package:rollbrett_rottweil/app_localizations.dart';
import 'package:rollbrett_rottweil/course_preview/course_preview.dart';
import 'package:rollbrett_rottweil/local_dealer/local_dealer.dart';
import 'package:rollbrett_rottweil/reusable/rollbrett_logo.dart';
import 'package:rollbrett_rottweil/skate_dice/skate_dice.dart';
import 'custom_icons.dart';

class HomePage extends StatelessWidget {
  _coursePreviewPressed(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CoursePreview()));
  }

  _skateDicePressed(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SkateDice()));
  }

  _localeDealerPressed(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LocalDealer()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Column(children: [
            HomePageTopBar(),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //TODO: fix icons
                HomePageButton(
                    AppLocalizations.of(context).translate('course_preview'),
                    CustomIcons.noun_half_pipe_699586,
                    () => _coursePreviewPressed(context)),
                HomePageButton("Skate Dice", CustomIcons.dice,
                    () => _skateDicePressed(context)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DisabledHomePageButton(
                    "Own the Spot", CustomIcons.video_camera, null),
                HomePageButton("Local Dealer", CustomIcons.skateboard,
                    () => _localeDealerPressed(context)),
              ],
            ),
          ]),
        ),
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
                child: RollbrettLogo(MediaQuery.of(context).size.height > 750.0
                    ? LogoSize.medium
                    : LogoSize.small)),
            LogoutButton()
          ],
        ),
        SizedBox(height: 15),
        Text(
          "Rollbrett Rottweil",
          style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: MediaQuery.of(context).size.width / 13,
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
            TextButton(
              onPressed: () => {Navigator.of(context).pop()},
              child: Column(
                children: [
                  Icon(
                    Icons.power_settings_new,
                    color: Theme.of(context).accentColor,
                    size: MediaQuery.of(context).size.width * 0.08,
                  ),
                  Text(
                    AppLocalizations.of(context).translate("logout"),
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
                      fontSize: 20, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
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
            Icon(
              Icons.lock,
              size: 50,
              color: Theme.of(context).accentColor,
            ),
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
