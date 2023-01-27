import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:vai_raja_vai/models/game_data.dart';
import 'package:vai_raja_vai/screens/PlayerListOld.dart';
import 'package:vai_raja_vai/screens/games_screen.dart';
import 'package:vai_raja_vai/screens/players_screen.dart';
import 'package:vai_raja_vai/splash.dart';
import './models/model.dart';
import './models/db_provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  // runApp(ChangeNotifierProvider(
  // create: (_) => DatabaseProvider(),
  runApp(
    // ChangeNotifierProvider(
    //   create: (BuildContext context) => PlayerData(),
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GameData(),
        ),
        ChangeNotifierProvider(
          create: (context) => DatabaseProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'வை ராஜா வை',
      theme: ThemeData(
        primarySwatch: Colors.red,
        // colorSchemeSeed: Colors.red,
      ),
      home: const Splash(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();

    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    provider.getPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'There are players!',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PlayerListOld()),
                );
              },
              child: const Text('Goto Players'),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'No games played yet!',
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Start Game'),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'No games played yet!',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PlayersScreen()),
                );
              },
              child: const Text('Players Home'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GamesScreen()),
                );
              },
              child: const Text('Goto Games Home'),
            ),
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headline4,
            // ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
