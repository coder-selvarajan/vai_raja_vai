import 'package:isar/isar.dart';

part 'player.g.dart';

@Collection()
class Player {
  Id id = Isar.autoIncrement;
  late String name;
}
