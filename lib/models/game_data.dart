import 'package:flutter/foundation.dart';
import 'package:vai_raja_vai/models/model.dart';
import 'dart:collection';

class GameData extends ChangeNotifier {
  final List<Player> _players = [];
  final List<Cutfor> _games = [];
  final List<Round> _rounds = [];

  List<Player> get players {
    return [..._players];
  }

  List<Cutfor> get games {
    return [..._games.reversed];
  }

  List<Round> get rounds {
    return [..._rounds];
  }

  int get playerCount {
    return _players.length;
  }

  int get gameCount {
    return _games.length;
  }

  int getLastCutforId() {
    return _games.last.id!;
  }

  Cutfor? selectedGame;
  Cutfor? currentGame;

  void initialize() {
    if (_players.isNotEmpty) {
      return;
    }
    // adding 5 players
    _players.add(Player(id: 1, name: "Ramesh", shortname: "RA"));
    _players.add(Player(id: 2, name: "Elango", shortname: "EL"));
    _players.add(Player(id: 3, name: "Mohan", shortname: "MO"));
    _players.add(Player(id: 4, name: "Manikkam", shortname: "MA"));
    _players.add(Player(id: 5, name: "Thambi", shortname: "TH"));
    _players.add(Player(id: 6, name: "Selvarajan", shortname: "SE"));
    _players.add(Player(id: 7, name: "Siva", shortname: "SI"));
    _players.add(Player(id: 8, name: "Muthusamy", shortname: "MU"));

    // adding 2 cutfors..
    _games.add(Cutfor(
        id: 2,
        time: DateTime.now(),
        players: [_players[1], _players[3], _players[4]], //EL, SI, NA
        place: "Nambiyur",
        status: "Completed"));
    _games.add(Cutfor(
        id: 1,
        time: DateTime.now(),
        players: [
          _players[0],
          _players[1],
          _players[2],
          _players[3],
          _players[6],
          _players[7]
        ], //RA, EL, MA, SI, MO, MU
        place: "Gobi",
        status: "Progressing"));

    // adding round entries for cutfor 1
    _rounds.add(Round(
      id: 1,
      cutforId: 1,
      roundNo: 1,
      time: DateTime.now(),
      entries: [
        RoundEntry(roundNo: 1, player: _players[0], toPay: 20),
        RoundEntry(roundNo: 1, player: _players[1], toPay: -1),
        RoundEntry(roundNo: 1, player: _players[2], toPay: 40),
        RoundEntry(roundNo: 1, player: _players[3], toPay: 20),
        RoundEntry(roundNo: 1, player: _players[6], toPay: 0),
        RoundEntry(roundNo: 1, player: _players[7], toPay: 20),
      ],
    ));
    _rounds.add(Round(
      id: 2,
      cutforId: 1,
      roundNo: 2,
      time: DateTime.now(),
      entries: [
        RoundEntry(roundNo: 2, player: _players[0], toPay: -1),
        RoundEntry(roundNo: 2, player: _players[1], toPay: 0),
        RoundEntry(roundNo: 2, player: _players[2], toPay: 20),
        RoundEntry(roundNo: 2, player: _players[3], toPay: 20),
        RoundEntry(roundNo: 2, player: _players[6], toPay: 20),
        RoundEntry(roundNo: 2, player: _players[7], toPay: 40),
      ],
    ));
    _rounds.add(Round(
      id: 3,
      cutforId: 1,
      roundNo: 3,
      time: DateTime.now(),
      entries: [
        RoundEntry(roundNo: 3, player: _players[0], toPay: 20),
        RoundEntry(roundNo: 3, player: _players[1], toPay: 20),
        RoundEntry(roundNo: 3, player: _players[2], toPay: 40),
        RoundEntry(roundNo: 3, player: _players[3], toPay: 40),
        RoundEntry(roundNo: 3, player: _players[6], toPay: 40),
        RoundEntry(roundNo: 3, player: _players[7], toPay: -1),
      ],
    ));
    _rounds.add(Round(
      id: 4,
      cutforId: 1,
      roundNo: 4,
      time: DateTime.now(),
      entries: [
        RoundEntry(roundNo: 4, player: _players[0], toPay: 80),
        RoundEntry(roundNo: 4, player: _players[1], toPay: 40),
        RoundEntry(roundNo: 4, player: _players[2], toPay: 20),
        RoundEntry(roundNo: 4, player: _players[3], toPay: -1),
        RoundEntry(roundNo: 4, player: _players[6], toPay: 40),
        RoundEntry(roundNo: 4, player: _players[7], toPay: 20),
      ],
    ));
    _rounds.add(Round(
      id: 5,
      cutforId: 1,
      roundNo: 5,
      time: DateTime.now(),
      entries: [
        RoundEntry(roundNo: 5, player: _players[0], toPay: -1),
        RoundEntry(roundNo: 5, player: _players[1], toPay: 40),
        RoundEntry(roundNo: 5, player: _players[2], toPay: 0),
        RoundEntry(roundNo: 5, player: _players[3], toPay: 20),
        RoundEntry(roundNo: 5, player: _players[6], toPay: 20),
        RoundEntry(roundNo: 5, player: _players[7], toPay: 40),
      ],
    ));

    // adding round entries for cutfor 2
    _rounds.add(Round(
      id: 11,
      cutforId: 2,
      roundNo: 1,
      time: DateTime.now(),
      entries: [
        RoundEntry(roundNo: 1, player: _players[1], toPay: -1),
        RoundEntry(roundNo: 1, player: _players[3], toPay: 80),
        RoundEntry(roundNo: 1, player: _players[4], toPay: 20)
      ],
    ));
    _rounds.add(Round(
      id: 12,
      cutforId: 2,
      roundNo: 2,
      time: DateTime.now(),
      entries: [
        RoundEntry(roundNo: 2, player: _players[1], toPay: 00),
        RoundEntry(roundNo: 2, player: _players[3], toPay: 20),
        RoundEntry(roundNo: 2, player: _players[4], toPay: -1)
      ],
    ));
    _rounds.add(Round(
      id: 13,
      cutforId: 2,
      roundNo: 3,
      time: DateTime.now(),
      entries: [
        RoundEntry(roundNo: 3, player: _players[1], toPay: 40),
        RoundEntry(roundNo: 3, player: _players[3], toPay: 00),
        RoundEntry(roundNo: 3, player: _players[4], toPay: -1)
      ],
    ));
    _rounds.add(Round(
      id: 14,
      cutforId: 2,
      roundNo: 4,
      time: DateTime.now(),
      entries: [
        RoundEntry(roundNo: 4, player: _players[1], toPay: -1),
        RoundEntry(roundNo: 4, player: _players[3], toPay: 40),
        RoundEntry(roundNo: 4, player: _players[4], toPay: 20)
      ],
    ));
    _rounds.add(Round(
      id: 15,
      cutforId: 2,
      roundNo: 5,
      time: DateTime.now(),
      entries: [
        RoundEntry(roundNo: 5, player: _players[1], toPay: 80),
        RoundEntry(roundNo: 5, player: _players[3], toPay: -1),
        RoundEntry(roundNo: 5, player: _players[4], toPay: 20)
      ],
    ));
    _rounds.add(Round(
      id: 16,
      cutforId: 2,
      roundNo: 6,
      time: DateTime.now(),
      entries: [
        RoundEntry(roundNo: 6, player: _players[1], toPay: 80),
        RoundEntry(roundNo: 6, player: _players[3], toPay: 80),
        RoundEntry(roundNo: 6, player: _players[4], toPay: -1)
      ],
    ));
    _rounds.add(Round(
      id: 17,
      cutforId: 2,
      roundNo: 7,
      time: DateTime.now(),
      entries: [
        RoundEntry(roundNo: 7, player: _players[1], toPay: 20),
        RoundEntry(roundNo: 7, player: _players[3], toPay: -1),
        RoundEntry(roundNo: 7, player: _players[4], toPay: 20)
      ],
    ));
  }

  void addPlayer(String name, String shortname) {
    _players.add(Player(name: name, shortname: shortname));
    notifyListeners();
  }

  void editPlayer(int playerId, String name, String shortname) {
    Player player = _players.firstWhere((element) => element.id == playerId);
    player.name = name;
    player.shortname = shortname;

    notifyListeners();
  }

  void addCutfor(
      List<Player> players, String place, DateTime time, String status) {
    var cutforId = 1;
    if (_games.length > 1) {
      cutforId = _games.last.id! + 1;
    }
    _games.add(Cutfor(
        id: cutforId,
        time: time,
        players: players,
        place: place,
        status: status));
    notifyListeners();
  }

  void addRound(int cutforId, List<RoundEntry> entries, int roundNo) {
    _rounds.add(Round(
        id: rounds.last.id! + 1,
        cutforId: cutforId,
        roundNo: roundNo,
        time: DateTime.now(),
        entries: entries));

    notifyListeners();
  }

  void editRound(int roundId, List<RoundEntry> entries) {
    Round round = _rounds.firstWhere((element) => element.id == roundId);
    round.entries = entries;
    round.time = DateTime.now();

    notifyListeners();
  }

  List<Round> getRounds(int cutforId) {
    List<Round> filteredRounds =
        rounds.where((value) => (value.cutforId == cutforId)).toList();
    return filteredRounds;
  }
}
