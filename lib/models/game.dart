import 'package:isar/isar.dart';

part 'game.g.dart';

@Collection()
class GameX {
  Id id = Isar.autoIncrement;
  late DateTime time;
  late String? place;

  @Enumerated(EnumType.name)
  late Status? status;

  late List<String> players;
  late List<RoundX>? rounds;
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

  late List<RoundEntryX> entries;
}

@embedded
class RoundEntryX {
  late String player;
  late int toPay;
}
