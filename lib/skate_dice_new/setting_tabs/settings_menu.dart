import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:rollbrett_rottweil/custom_icons.dart';

import 'package:rollbrett_rottweil/skate_dice_new/setting_tabs/settings_configuration.dart';
import 'package:rollbrett_rottweil/skate_dice_new/setting_tabs/obstacle_configuration.dart';
import 'package:rollbrett_rottweil/skate_dice_new/setting_tabs/tricks_configuration.dart';


class NavBar extends StatefulWidget {
  const NavBar({Key key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildBottomNavBar(),
      body: _buildPages(),
    );
  }

  Widget _buildPages() {
    switch (_index) {
      case 0:
        return AddPlayer();
      case 1:
        return ConfigureObstacles();
      case 2:
        return ConfigureTricks();
      default:
        return AddPlayer();
    }
  }

  Widget buildBottomNavBar() {
    return BottomNavyBar(
        itemCornerRadius: 16,
        containerHeight: MediaQuery.of(context).size.height / 11,
        selectedIndex: _index,
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              icon: Icon(Icons.person_add),
              title: Text(
                'Add Player',
                textAlign: TextAlign.center,
              ),
              activeColor: Theme.of(context).accentColor,
              inactiveColor: Theme.of(context).accentColor),
          BottomNavyBarItem(
              icon: Icon(CustomIcons.noun_half_pipe_699586),
              title: Text(
                'Obstacles',
                textAlign: TextAlign.center,
              ),
              activeColor: Theme.of(context).accentColor,
              inactiveColor: Theme.of(context).accentColor),
          BottomNavyBarItem(
              icon: Icon(CustomIcons.skateboard),
              title: Text(
                'Tricks',
                textAlign: TextAlign.center,
              ),
              activeColor: Theme.of(context).accentColor,
              inactiveColor: Theme.of(context).accentColor),
        ],
        onItemSelected: (index) => setState(() => this._index = index));
  }
}
