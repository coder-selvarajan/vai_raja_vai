import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'model.dart';

class DatabaseProvider with ChangeNotifier {
  List<Player> _players = [];
  List<Player> get players => _players;

  Database? _database;
  Future<Database> get database async {
    // database directory
    final dbpath = await getDatabasesPath();
    const dbname = 'vairaja.db';
    //full path
    final path = join(dbpath, dbname);

    // open the connection
    _database = await openDatabase(path, version: 1, onCreate: _createDB);

    return _database!;
  }

  //Create tables and insert the initial values
  static const pTable = "Player";
  static const gTable = "Game";
  static const gpTable = "GamePlayer";
  static const rTable = "Round";
  static const reTable = "RoundEntry";
  Future<void> _createDB(Database db, int version) async {
    await db.transaction((txn) async {
      //Player table
      await txn.execute('''
      CREATE TABLE $pTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        shortname TEXT,
        color TEXT
      )
      ''');

      //Game table
      await txn.execute('''
      CREATE TABLE $gTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        time TEXT,
        playercount INTEGER
      )
      ''');

      //GamePlayer table
      await txn.execute('''
      CREATE TABLE $gpTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        gameid INTEGER,
        playerid INTEGER
      )
      ''');

      //Round table
      await txn.execute('''
      CREATE TABLE $rTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        gameid INTEGER,
        time TEXT,
        winner INTEGER
      )
      ''');

      //RoundEntry table
      await txn.execute('''
      CREATE TABLE $reTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        gameid INTEGER,
        roundid INTEGER,
        playerid INTEGER,
        winnerid INTEGER,
        amount TEXT
      )
      ''');

      //insert the initial players
      await txn.insert(
          pTable,
          {
            'name': 'Ramesh',
            'shortname': 'RA',
            'color': "#FF0000",
          },
          conflictAlgorithm: ConflictAlgorithm.replace);
      // await txn.insert(
      //     pTable,
      //     {
      //       'name': 'Elango',
      //       'shortname': 'EL',
      //       'color': "#00FF00",
      //     },
      //     conflictAlgorithm: ConflictAlgorithm.replace);
      await txn.insert(
          pTable,
          {
            'name': 'Manikkam',
            'shortname': 'MA',
            'color': "#0000FF",
          },
          conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

  Future<void> addPlayer(Player player) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn
          .insert(
        pTable,
        player.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      )
          .then((generatedId) {
        // after inserting in a database. we store it in in-app memory with new expense with generated id
        final file = Player(
            id: generatedId, name: player.name, shortname: player.shortname);
        _players.add(file);
        // notify the listeners about the change in value of '_players'
        notifyListeners();
      });
    });
  }

  Future<void> deletePlayer(int playerId) async {
    final db = await database;

    // await db.delete(
    //   'player',
    //   where: 'id == ?',
    //   whereArgs: [player.id],
    // );

    await db.transaction((txn) async {
      await txn
          .delete(pTable, where: 'id == ?', whereArgs: [playerId]).then((_) {
        // remove from in-app memory too
        _players.removeWhere((player) => player.id == playerId);
        notifyListeners();
      });
    });
  }

  //getPlayers
  Future<List<Player>> getPlayers() async {
    final db = await database;

    return await db.transaction((txn) async {
      return await txn.query(pTable).then((data) {
        // 'data' is our fetched value
        // convert it from "Map<String, object>" to "Map<String, dynamic>"
        final converted = List<Map<String, dynamic>>.from(data);
        // create a 'Player' from every 'map' in this 'converted'
        List<Player> pList = List.generate(
            converted.length, (index) => Player.fromString(converted[index]));
        _players = pList;
        return _players;
      });
    });
  }
}
