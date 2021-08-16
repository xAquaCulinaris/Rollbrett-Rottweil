import 'package:flutter/material.dart';
import 'package:rollbrett_rottweil/skate_dice/models/Item.dart';

class StanceProvider with ChangeNotifier {
  List<ItemHeader> _items = [];

  StanceProvider() {
    _items = [
      ItemHeader("Stance", [
        Item("Regular", "none"),
        Item("Switch", "none"),
        Item("Fakie", "none"),
        Item("Nollie", "none")
      ])
    ];
    notifyListeners();
  }

  List<ItemHeader> get items => _items;

  List<Item> getSelectedStance() {
    List<Item> _selectedStance = [];
    for (ItemHeader header in _items) {
      _selectedStance
          .addAll(header.items.where((element) => element.checked).toList());
    }
    return _selectedStance;
  }
}
