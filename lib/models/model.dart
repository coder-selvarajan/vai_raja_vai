class Round {
  int? id;
  final int cutforId;
  final int roundNo;
  DateTime time;
  List<RoundEntry> entries;

  Round(
      {this.id,
      required this.cutforId,
      required this.roundNo,
      required this.time,
      required this.entries});
}

class RoundEntry {
  int? id;
  final int roundNo;
  final Player player;
  final int toPay;

  RoundEntry(
      {this.id,
      required this.roundNo,
      required this.player,
      required this.toPay});
}

class Cutfor {
  int? id;
  final DateTime time;
  final List<Player> players;
  final String? place;
  final String? status;

  Cutfor(
      {this.id,
      required this.time,
      required this.players,
      this.place,
      this.status});
}

class Player {
  int? id;
  String name;
  String shortname;

  Player({this.id, required this.name, required this.shortname});

  //to sqlite
  Map<String, dynamic> toMap() => {
        //id is auto generated
        'name': name,
        'shortname': shortname,
      };
  //from sqlite
  factory Player.fromString(Map<String, dynamic> value) => Player(
        id: value['id'],
        name: value['name'],
        shortname: value['shortname'],
      );

  //for debugging
  @override
  String toString() {
    return 'Player(id: $id, name: $name, shortname: $shortname';
  }
}
