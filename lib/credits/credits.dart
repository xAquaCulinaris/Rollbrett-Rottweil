import 'package:flutter/material.dart';
import 'package:rollbrett_rottweil/reusable/custom_app_bar.dart';

class Credits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [CustomAppBar(text: "Credits")],
    ));
  }
}
