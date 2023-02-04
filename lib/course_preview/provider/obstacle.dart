class Obstacle {
  Obstacle(this.name, this.imagePath, this.uid, this.videos);

  factory Obstacle.fromJson(Map<String, dynamic> json) {
    String name = json['name'];
    String imagePath = json['image'];
    String uid = json['uid'];
    List<VideoItem> videos = [];


    for (var idk in json['videos']) {
      videos.add(VideoItem(idk['title'], idk['video']));
    }

    return Obstacle(name, imagePath, uid, videos);
  }

  final String name;
  final String imagePath;
  final String uid;
  final List<VideoItem> videos;
  bool inRange = true;

  
}



class VideoItem {
  const VideoItem(this.title, this.videoPath);
  final String title;
  final String videoPath;
}