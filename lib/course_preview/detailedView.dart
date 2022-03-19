import 'package:flutter/material.dart';
import 'package:rollbrett_rottweil/course_preview/obstacles.dart';
import 'package:rollbrett_rottweil/course_preview/widgets/VideoPlayerWidget.dart';
import 'package:rollbrett_rottweil/reusable/custom_app_bar.dart';
import 'package:video_player/video_player.dart';

class DetailObstacleView extends StatefulWidget {
  DetailObstacleView(this.obstacle) : super();
  final Obstacle obstacle;

  @override
  _DetailObstacleViewState createState() => _DetailObstacleViewState();
}

class _DetailObstacleViewState extends State<DetailObstacleView> {
  VideoPlayerController videoController;

  @override
  void initState() {
    super.initState();
    videoController = VideoPlayerController.asset(
        "assets/course_preview/videos/kickflip_nosemanual.mp4")
      ..addListener(() {
        setState(() {});
      })
      ..initialize().then((_) => videoController.play());
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            text: widget.obstacle.name,
          ),
          Image(image: AssetImage(widget.obstacle.imagePath)),
          VideoPlayerWidget(controller: videoController)
        ],
      ),
    );
  }
}
