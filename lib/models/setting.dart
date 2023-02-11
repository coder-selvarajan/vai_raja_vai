import 'package:isar/isar.dart';

part 'setting.g.dart';

@Collection()
class Setting {
  Id id = Isar.autoIncrement;
  late int autoClosureHours = 2;
  late List<int> denominations = [0, 10, 20, 40, 80];
}
