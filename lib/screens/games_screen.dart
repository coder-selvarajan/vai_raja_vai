import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vai_raja_vai/screens/add_game_screen.dart';
import 'package:vai_raja_vai/screens/add_player_screen.dart';
import 'package:vai_raja_vai/screens/players_screen.dart';
import 'package:vai_raja_vai/widgets/games_list.dart';

import '../models/game_data.dart';
import '../models/model.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({Key? key}) : super(key: key);

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  final List<Player> _selected = <Player>[];

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    var provider = Provider.of<GameData>(context);
    provider.initialize();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120), //height of appbar
        child: Container(
          color: Colors.redAccent,
          child: Column(
            children: [
              AppBar(
                toolbarHeight: 100.0,
                backgroundColor: Colors.redAccent,
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/card-game.png",
                      height: 60,
                      width: 60,
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'வை ராஜா வை',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontFamily: "AnekTamil-Regular",
                            // fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Money Splitter for Rummy Game",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                elevation: 0,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Expanded(
            //   child: Container(
            Container(
              // height: 2000.0,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const GamesList(),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PlayersScreen()),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.play_circle_outline),
                          SizedBox(
                            width: 10,
                          ),
                          Text(" View All Games"),
                        ],
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 1.0, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Divider(
                      color: Colors.grey.withOpacity(0.3),
                      thickness: 1.0,
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Icon(
                          Icons.people,
                          size: 30.0,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Player List',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PlayersScreen()),
                            );
                          },
                          child: Text(" Edit / Add Player"),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(width: 1.0, color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15.0),
                    Wrap(
                      spacing: 5.0,
                      children: provider.players.map((Player player) {
                        return FilterChip(
                          label: Text(player.name),
                          selected: _selected.contains(player),
                          onSelected: (bool value) {
                            //
                          },
                        );
                      }).toList(),
                    ),
                    // const SizedBox(height: 10.0),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => const AddGame()),
                    //     );
                    //   },
                    //   child: Text("Add Player"),
                    // ),

                    // Text('Selected : ${_filters.join(', ')}'),
                  ],
                ),
              ),
            ),
            // ),
          ],
        ),
      ),
    );
  }
}
