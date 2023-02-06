import 'package:isar/isar.dart';

part 'player.g.dart';

@Collection()
class PlayerX {
  Id id = Isar.autoIncrement;
  late String name;
}
