import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:vai_raja_vai/screens/PlayerList.dart';
import 'package:vai_raja_vai/splash.dart';
import './models/model.dart';
import './models/db_provider.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  //default values in database..
  // var db = DatabaseConnect();
  // await db.insertPlayer(Player(id: 1, name: 'Ramesh', shortname: 'RA'));
  // await db.insertPlayer(Player(id: 2, name: 'Elango', shortname: 'EL'));
  // await db.insertPlayer(Player(id: 3, name: 'Mohan', shortname: 'MO'));
  // await db.insertPlayer(Player(id: 4, name: 'Manikkam', shortname: 'MA'));

  // print(await db.getPlayers());
  // runApp(const MyApp());
  runApp(ChangeNotifierProvider(
    create: (_) => DatabaseProvider(),
    child: const MyApp(),
  ));
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const PlayerList()),
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
