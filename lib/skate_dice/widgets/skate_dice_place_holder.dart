import 'package:flutter/material.dart';
import 'package:rollbrett_rottweil/skate_dice/widgets/skate_dice_dice.dart';

class SkateDicePlaceholder extends StatelessWidget {
  const SkateDicePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.width / 2.3,
        width: MediaQuery.of(context).size.width / 2.3,
        decoration: new BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: new BorderRadius.all(const Radius.circular(30.0)),
            ),
      ),
    );
  }
}