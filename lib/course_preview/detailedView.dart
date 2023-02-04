import 'package:flutter/material.dart';
import 'package:rollbrett_rottweil/course_preview/provider/obstacle.dart';
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
  List<VideoPlayerController> videoControllers = [];

  @override
  void initState() {
    super.initState();
    //add all video controllers to list
    for (var video in widget.obstacle.videos)
      videoControllers.add(VideoPlayerController.asset(video.videoPath)
        ..addListener(() {
          setState(() {});
        })
        ..initialize());
  }

  @override
  void dispose() {
    //dispose all video controllers
    for (var videoController in videoControllers) videoController.dispose();
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
          SingleChildScrollView(
            child: Column(
              children: [
                //Image of the obstacle
                //Image(image: AssetImage(widget.obstacle.imagePath)),
                //Display all the videos

          
                ListView(
                 // padding: EdgeInsets.only(top: 50),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: videoControllers.map((videoController) {
                      return VideoPlayerWidget(controller: videoController);
                    }).toList()),

                // ListView.builder(
                //     shrinkWrap: true,
                //     //physics: NeverScrollableScrollPhysics(),
                //     itemCount: videoControllers.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       return VideoPlayerWidget(controller: videoControllers[index]);
                //     }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
