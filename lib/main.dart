import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:vai_raja_vai/models/game_data.dart';
import 'package:vai_raja_vai/screens/home_screen.dart';
import 'package:vai_raja_vai/screens/players_screen.dart';
import 'package:vai_raja_vai/splash.dart';
import './models/model.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        // ChangeNotifierProvider(
        //   create: (context) => DatabaseProvider(),
        // ),
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
      // home: const MyHomePage(title: "வை ராஜா வை"),
      home: HomeScreen(),
    );
  }
}
