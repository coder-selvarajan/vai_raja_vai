import 'package:flutter/foundation.dart';
import 'package:vai_raja_vai/models/model.dart';
import 'dart:collection';

class GameData extends ChangeNotifier {
  final List<Player> _players = [
    Player(name: "Ramesh", shortname: "RA", color: "FF0000"),
    Player(name: "Elango", shortname: "EL", color: "00FF00"),
    Player(name: "Manikkam", shortname: "MA", color: "0000FF"),
  ];

  final List<Cutfor> _games = [
    Cutfor(
        time: DateTime.now(),
        players: [
          Player(name: "Ramesh", shortname: "RA", color: "FF0000"),
          Player(name: "Elango", shortname: "EL", color: "00FF00"),
          Player(name: "Manikkam", shortname: "MA", color: "0000FF"),
        ],
        place: "Gobi"),
    Cutfor(
        time: DateTime.now(),
        players: [
          Player(name: "Siva", shortname: "SI", color: "FF0000"),
          Player(name: "Elango", shortname: "EL", color: "00FF00"),
          Player(name: "Natarajan", shortname: "NA", color: "0000FF"),
        ],
        place: "Nambiyur"),
  ];

  List<Player> get players {
    return [..._players];
  }

  List<Cutfor> get games {
    return [..._games];
  }

  int get playerCount {
    return _players.length;
  }

  int get gameCount {
    return _games.length;
  }

  void addPlayer(String name, String shortname, String color) {
    _players.add(Player(name: name, shortname: shortname, color: color));
    notifyListeners();
  }

  void addCutfor(List<Player> players, String place, DateTime time) {
    _games.add(Cutfor(time: time, players: players, place: place));
    notifyListeners();
  }
}
