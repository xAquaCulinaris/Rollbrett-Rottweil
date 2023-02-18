import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rollbrett_rottweil/skate_dice/models/ItemHeader.dart';
import 'package:rollbrett_rottweil/skate_dice_new/models/checkbox_header.dart';
import 'package:rollbrett_rottweil/skate_dice_new/models/trick.dart';

class TrickProvider with ChangeNotifier {
  List<CheckBoxHeader> _items = [];
  bool tricksLoaded = false;

  TrickProvider() {
    loadTricks().then((items) {
      _items = items;
      tricksLoaded = true;
      notifyListeners();
      print("loaded tricks");
    });
  }

  List<CheckBoxHeader> get items => _items;

  Future loadTricks() async {
    String data = await rootBundle.loadString("assets/skate_dice/tricks.json");
    final jsonResult = json.decode(data);

    return jsonResult
        .map<CheckBoxHeader>(
            (jsonTrickCategory) => CheckBoxHeader.fromJson(jsonTrickCategory))
        .toList();
  }
}
