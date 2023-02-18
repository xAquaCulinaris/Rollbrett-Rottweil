import 'package:rollbrett_rottweil/skate_dice_new/models/checkbox_item.dart';
import 'package:rollbrett_rottweil/skate_dice_new/models/enums/difficultys.dart';
import 'package:rollbrett_rottweil/skate_dice_new/models/enums/obstacle_types.dart';
import 'package:rollbrett_rottweil/skate_dice_new/models/trick.dart';

class CheckBoxHeader {
  CheckBoxHeader(this.name, this.children);

  //name displayed in headline
  final String name;
  //are children shown or hidden
  bool expanded = false;
  //used to deselect all children
  bool checked = true;
  //if type radio is true only one children can be selected
  bool typeRadio = false;
  //child items
  List<CheckBoxItem> children;

  //function to call if item should be selected
  void itemSelected(CheckBoxItem selectedItem) {
    //if checkbox of type radio button
    if (typeRadio) {
      for (var child in children) {
        //if item should be selected set to true
        if (child == selectedItem)
          child.checked = true;
        //else set all other items to false
        else
          child.checked = false;
      }
    }
    //if normal checkbox
    else {
      //only set current item checked to true
      selectedItem.checked = true;
    }
  }


  //Create object from json string
  factory CheckBoxHeader.fromJson(Map<String, dynamic> json) {
    List<CheckBoxItem> children = [];

    for (var item in json['items']) {
      String name = item['name'];
      String obstacleTypeString = item['obstacleType'];
      bool directional = item['directional'].toString().parseBool();
      String difficulty = item['difficulty'];
      String obstacleLink = item['obstacle_link'];

      ExtendedDifficulty generalDifficulty = enumFromString(ExtendedDifficulty.values, difficulty);
      ExtendedDifficulty trickIntoDifficulty = enumFromString(ExtendedDifficulty.values, difficulty);
      ExtendedDifficulty stanceDifficulty = enumFromString(ExtendedDifficulty.values, difficulty);

      ObstacleType obstacleType = enumFromString(ObstacleType.values, obstacleTypeString);
      
      //create trick and add to children list
      children.add(Trick(name, generalDifficulty, trickIntoDifficulty, stanceDifficulty, directional, obstacleType));
    }

    return CheckBoxHeader(json['name'], children);
  }
}

extension BoolParsing on String {
  bool parseBool() {
    if (this.toLowerCase() == 'true') {
      return true;
    } else if (this.toLowerCase() == 'false') {
      return false;
    }
    return null;
  }
}

T enumFromString<T>(Iterable<T> values, String value) {
  return values.firstWhere((type) => type.toString().split(".").last == value,
      orElse: () => null);
}