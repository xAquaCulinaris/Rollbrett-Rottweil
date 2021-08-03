import 'package:flutter/material.dart';

class RollbrettLogo extends StatelessWidget {
  RollbrettLogo(this.logoSize);
  final LogoSize logoSize;

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: MediaQuery.of(context).size.width * logoSize.size,
      height: MediaQuery.of(context).size.width * logoSize.size,
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

enum LogoSize { small, medium, big }

extension LogoSizeExtension on LogoSize {
  static const sizes = {
    LogoSize.small: 0.4,
    LogoSize.medium: 0.5,
    LogoSize.big: 0.6,
  };

  double get size => sizes[this];
}
