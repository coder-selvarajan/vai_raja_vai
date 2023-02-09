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
        [PlayerSchema, GameSchema],
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }

  Future<void> savePlayer(Player newPlayer) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.players.putSync(newPlayer));
  }

  Future<void> deletePlayer(Player player) async {
    final isar = await db;
    await isar.writeTxn(() async {
      final success = await isar.players.delete(player.id);
      // print('Recipe deleted: $success');
    });
  }

  Future<void> saveGame(Game newGame) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.games.putSync(newGame));
  }

  Future<void> deleteGame(Id gameId) async {
    final isar = await db;
    await isar.writeTxn(() async {
      final success = await isar.games.delete(gameId);
      // print('Recipe deleted: $success');
    });
  }

  Future<void> updateGameStatus() async {
    final isar = await db;
    await isar.writeTxn(() async {
      List<Game> games = await isar.games
          .filter()
          .statusEqualTo(Status.Progressing)
          .timeLessThan(DateTime.now().subtract(const Duration(hours: 2)))
          .findAll();

      for (var game in games) {
        game.status = Status.Completed;
        await isar.games.put(game);
      }
    });
  }

  Stream<List<Player>> streamPlayers() async* {
    final isar = await db;
    yield* isar.players.where().watch(fireImmediately: true);
  }

  Future<List<Player>> getPlayersList() async {
    final isar = await db;
    return await isar.players.where().findAll();
  }

  Future<int> getPlayersCount() async {
    final isar = await db;
    return await isar.players.count();
  }

  Stream<List<Game>> streamGames() async* {
    final isar = await db;
    yield* isar.games.where().sortByTimeDesc().watch(fireImmediately: true);
  }

  Stream<List<Game>> streamRecentGames() async* {
    final isar = await db;
    yield* isar.games
        .where()
        .sortByTimeDesc()
        .limit(3)
        .watch(fireImmediately: true);
  }

  Stream<List<Game>> getGameById(Id id) async* {
    final isar = await db;
    yield* isar.games
        .filter()
        .idEqualTo(id.toInt())
        .watch(fireImmediately: true);
  }
}
