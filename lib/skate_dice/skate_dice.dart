import 'package:flutter/material.dart';
import 'package:rollbrett_rottweil/reusable/custom_app_bar.dart';

class SkateDice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    settingButtonPressed() {
      print("setting button pressed");
    }

    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
              text: "Skate Dice",
              iconRight: Icons.settings,
              functionRight: settingButtonPressed),
        ],
      ),
    );
  }
}
