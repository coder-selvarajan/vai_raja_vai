import 'package:isar/isar.dart';

part 'game.g.dart';

@Collection()
class Game {
  Id id = Isar.autoIncrement;
  late DateTime time;
  late String? place;

  @Enumerated(EnumType.name)
  late Status? status;

  late List<String> players = List.empty(growable: true);
  late List<Round>? rounds = List.empty(growable: true);
}

enum Status {
  Progressing(0),
  Completed(1);

  const Status(this.myValue);
  final short myValue;
}

@embedded
class Round {
  late int roundNo;
  late DateTime time;

  late List<RoundEntry> entries = List.empty(growable: true);
}

@embedded
class RoundEntry {
  late String player;
  late int toPay;
}
