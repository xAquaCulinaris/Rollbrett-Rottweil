class ItemHeader {
  final String name;
  bool expanded = false;
  final List<Item> items;

  ItemHeader(this.name, this.items);

  factory ItemHeader.fromJson(Map<String, dynamic> json) {
    List<Item> itemList = [];
    for (var item in json['items']) {
      itemList.add(Item(
          item['name'], item['obstacleType']));
    }
    return ItemHeader(json['name'], itemList);
  }
}

class Item {
  final String name;
  bool checked = true;
  ObstacleType obstacleType;

  Item(this.name, String obstacleType) {
    switch (obstacleType) {
      case 'flat':
        this.obstacleType = ObstacleType.Flat;
        break;
      case 'grind':
        this.obstacleType = ObstacleType.Grind;
        break;
      case 'manual':
        this.obstacleType = ObstacleType.Manual;
        break;
      case 'transition':
        this.obstacleType = ObstacleType.Transition;
        break;
    }
  }
}

enum ObstacleType { Flat, Grind, Manual, Transition }
