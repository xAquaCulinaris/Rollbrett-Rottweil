class ObstacleHeader {
  final String name;
  bool expanded = false;
  final List<Obstacle> obstacles;

  ObstacleHeader(this.name, this.obstacles);

  factory ObstacleHeader.fromJson(Map<String, dynamic> json) {
    List<Obstacle> obstacleList = [];
      for (var obstacle in json['obstacles']) {
        obstacleList.add(Obstacle(
            obstacle['name'], obstacle['checked'], obstacle['obstacleType']));
      }
    return ObstacleHeader(json['name'], obstacleList);
  }
}

class Obstacle {
  final String name;
  bool checked;
  ObstacleType obstacleType;

  Obstacle(this.name, this.checked, String obstacleType) {
    switch (obstacleType) {
      case 'flat':
        this.obstacleType = ObstacleType.Flat;
        break;
      case 'grind':
        this.obstacleType = ObstacleType.Grind;
        break;
      case 'manny':
        this.obstacleType = ObstacleType.MannyPad;
        break;
      case 'transition':
        this.obstacleType = ObstacleType.Transition;
        break;
    }
  }

  // static Future<List<ObstacleHeader>> getObstacles() async {
  //   String data =
  //       await rootBundle.loadString("assets/skate_dice/obstacles.json");
  //   final jsonResult = json.decode(data);

  //   List<ObstacleHeader> obstacleHeaderList = [];

  //   for (var obstacleHeader in jsonResult) {
  //     String name = obstacleHeader['name'];
  //     List<Obstacle> obstacleList = [];
  //     for (var obstacle in obstacleHeader['obstacles']) {
  //       obstacleList.add(Obstacle(
  //           obstacle['name'], obstacle['checked'], obstacle['obstacleType']));
  //     }
  //     obstacleHeaderList.add(ObstacleHeader(name, obstacleList));
  //   }

  //   return obstacleHeaderList;
  // }
}

enum ObstacleType { Flat, Grind, MannyPad, Transition }
