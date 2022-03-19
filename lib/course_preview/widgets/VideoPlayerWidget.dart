import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const VideoPlayerWidget({Key key, @required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) =>
      controller != null && controller.value.isInitialized
          ? Container(alignment: Alignment.topCenter, child: buildVideo())
          : Container(
              height: 200, child: Center(child: CircularProgressIndicator()));

  Widget buildVideo() => Stack(children: [
        buildVideoPlayer(),
        Positioned.fill(child: VideoOverlayWidget(controller: controller)),
      ]);

  Widget buildVideoPlayer() => AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: VideoPlayer(controller));
}

class VideoOverlayWidget extends StatelessWidget {
  const VideoOverlayWidget({Key key, @required this.controller})
      : super(key: key);
  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        print("pressed");
        return controller.value.isPlaying
            ? controller.pause()
            : controller.play();
      },
      child: Stack(
        children: [
          buildPlay(),
          Positioned(bottom: 5, right: 0, child: buildMute(context)),
          Positioned(
              bottom: 0, left: 0, right: 0, child: buildIndicator(context)),
        ],
      ),
    );
  }

  Widget buildIndicator(BuildContext context) =>
      VideoProgressIndicator(controller,
          allowScrubbing: true,
          colors: VideoProgressColors(
              playedColor: Theme.of(context).scaffoldBackgroundColor));

  Widget buildPlay() => controller.value.isPlaying
      ? Container()
      : Container(
          color: Colors.black26,
          alignment: Alignment.center,
          child: Icon(Icons.play_arrow, color: Colors.white, size: 80));

  Widget buildMute(BuildContext context) => IconButton(
      onPressed: () =>
          controller.setVolume(controller.value.volume == 0.0 ? 1.0 : 0.0),
      icon: Icon(
          controller.value.volume == 0 ? Icons.music_off : Icons.music_note,
          color: Theme.of(context).scaffoldBackgroundColor));
}
