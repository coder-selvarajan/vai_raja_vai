import 'package:isar/isar.dart';
import 'package:vai_raja_vai/models/game.dart';
import 'package:vai_raja_vai/models/player.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [PlayerXSchema, GameXSchema],
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }

  Future<void> savePlayer(PlayerX newPlayer) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.playerXs.putSync(newPlayer));
  }

  Future<void> saveGame(GameX newGame) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.gameXs.putSync(newGame));
  }

  Stream<List<PlayerX>> getAllPlayers() async* {
    final isar = await db;
    yield* isar.playerXs.where().watch(fireImmediately: true);
  }

  Stream<List<GameX>> getAllGames() async* {
    final isar = await db;
    yield* isar.gameXs.where().watch(fireImmediately: true);
  }

  Future<List<PlayerX>> getPlayers() async {
    final isar = await db;
    return await isar.playerXs.where().findAll();
  }
}
