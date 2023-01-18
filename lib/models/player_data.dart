import 'package:flutter/foundation.dart';
import 'package:vai_raja_vai/models/model.dart';
import 'dart:collection';

class PlayerData extends ChangeNotifier {
  final List<Player> _players = [
    Player(name: "Ramesh", shortname: "RA", color: "FF0000"),
    Player(name: "Elango", shortname: "EL", color: "00FF00"),
    Player(name: "Manikkam", shortname: "MA", color: "0000FF"),
  ];

  List<Player> get Players {
    return [..._players];
  }

  int get playerCount {
    return _players.length;
  }

  void addPlayer(String name, String shortname, String color) {
    _players.add(Player(name: name, shortname: shortname, color: color));
    notifyListeners();
  }
}
