import 'package:isar/isar.dart';

part 'game.g.dart';

@Collection()
class GameX {
  Id id = Isar.autoIncrement;
  late DateTime time;
  late String? place;

  @Enumerated(EnumType.name)
  late Status? status;

  late List<String> players = List.empty(growable: true);
  late List<RoundX>? rounds = List.empty(growable: true);
}

enum Status {
  Progressing(0),
  Completed(1);

  const Status(this.myValue);
  final short myValue;
}

@embedded
class RoundX {
  late int roundNo;
  late DateTime time;

  late List<RoundEntryX> entries = List.empty(growable: true);
}

@embedded
class RoundEntryX {
  late String player;
  late int toPay;
}
