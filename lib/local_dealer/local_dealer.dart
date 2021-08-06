import 'package:flutter/material.dart';
import 'package:rollbrett_rottweil/reusable/app_bar.dart';

class LocalDealer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        CustomAppBar(text: "Local Dealer")
      ],)
      
    );
  }
}