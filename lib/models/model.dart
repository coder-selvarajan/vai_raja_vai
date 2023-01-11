class Player {
  int? id;
  final String name;
  final String shortname;
  final String color;

  Player(
      {this.id,
      required this.name,
      required this.shortname,
      required this.color});

  //to sqlite
  Map<String, dynamic> toMap() => {
        //id is auto generated
        'name': name,
        'shortname': shortname,
        'color': color,
      };
  //from sqlite
  factory Player.fromString(Map<String, dynamic> value) => Player(
        id: value['id'],
        name: value['name'],
        shortname: value['shortname'],
        color: value['color'],
      );

  //for debugging
  @override
  String toString() {
    return 'Player(id: $id, name: $name, shortname: $shortname, color: $color';
  }
}

class Game {
  int? id;
  final DateTime time;
  final int playercount;

  Game({this.id, required this.time, required this.playercount});

  //for sqlite
  Map<String, dynamic> toMap() => {
        // id auto generated
        'time': time.millisecondsSinceEpoch,
        'playercount': playercount,
      };
  factory Game.fromString(Map<String, dynamic> value) => Game(
        id: value['id'],
        time: DateTime.fromMillisecondsSinceEpoch(value['time']),
        playercount: value['playercount'],
      );

  //for debugging
  @override
  String toString() {
    return 'Game(id: $id, time: $time, playercount: $playercount';
  }
}

class GamePlayer {
  int? id;
  final int gameid;
  final int playerid;

  GamePlayer({this.id, required this.gameid, required this.playerid});

  //for sqlite
  Map<String, dynamic> toMap() => {
        //id auto generated
        'gameid': gameid,
        'playerid': playerid,
      };
  factory GamePlayer.fromString(Map<String, dynamic> value) => GamePlayer(
        id: value['id'],
        gameid: value['gameid'],
        playerid: value['playerid'],
      );

  //for debugging
  @override
  String toString() {
    return 'GamePlayer(id: $id, gameid: $gameid, playerid: $playerid';
  }
}

class Round {
  int? id;
  final int gameid;
  final DateTime time;
  final int winner; //playerid

  Round(
      {this.id,
      required this.gameid,
      required this.time,
      required this.winner});

  //for sqlite
  Map<String, dynamic> toMap() => {
        // id auto generated
        'gameid': gameid,
        'time': time.millisecondsSinceEpoch,
        'winner': winner,
      };
  factory Round.fromString(Map<String, dynamic> value) => Round(
        id: value['id'],
        gameid: value['gameid'],
        time: DateTime.fromMillisecondsSinceEpoch(value['time']),
        winner: value['winner'],
      );

  //for debugging
  @override
  String toString() {
    return 'Round(id: $id, gameid: $gameid, time: $time, winner: $winner';
  }
}

class RoundEntry {
  int? id;
  final int gameid;
  final int roundid;
  final int playerid;
  final int winnerid;
  final double amount;

  RoundEntry(
      {this.id,
      required this.gameid,
      required this.roundid,
      required this.playerid,
      required this.winnerid,
      required this.amount});

  //for sqlite
  Map<String, dynamic> toMap() => {
        //id auto increment
        'gameid': gameid,
        'roundid': roundid,
        'playerid': playerid,
        'winnerid': winnerid,
        'amount': amount.toString(),
      };
  factory RoundEntry.fromString(Map<String, dynamic> value) => RoundEntry(
        id: value['id'],
        gameid: value['gameid'],
        roundid: value['roundid'],
        playerid: value['playerid'],
        winnerid: value['winnerid'],
        amount: double.parse(value['amount']),
      );

  //for debugging
  @override
  String toString() {
    return 'RoundEntry(id: $id, gameid: $gameid, roundid: $roundid, playerid: $playerid, winnerid:$winnerid, amount:$amount';
  }
}
