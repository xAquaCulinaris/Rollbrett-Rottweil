import 'package:flutter/material.dart';

class RollbrettLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return new Container(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.width * 0.6,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/images/rollbrett_rottweil.jpg'),
          ),
        ),
      );
  }

}