import 'package:flutter/material.dart';
import 'package:rollbrett_rottweil/course_preview/obstacles.dart';
import 'package:rollbrett_rottweil/reusable/custom_app_bar.dart';

import '../app_localizations.dart';

class DetailObstacleView extends StatelessWidget {
  const DetailObstacleView(this.obstacle) : super();
  final Obstacle obstacle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            text: obstacle.name,
          ),
          Text("Placeholder"),
        ],
      ),
    );
  }
}
