import 'package:flutter/material.dart';
import 'package:vai_raja_vai/models/isar_service.dart';
import 'package:vai_raja_vai/models/player.dart';
import 'package:vai_raja_vai/screens/games_screen.dart';
import 'package:vai_raja_vai/screens/players_screen.dart';
import 'package:vai_raja_vai/widgets/recent_games.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<PlayerX> _selected = <PlayerX>[];

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

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
                      children: [
                        Image.asset(
                          "assets/VRV_Logo.png",
                          // height: 100.0,
                          width: 200.0,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          "Money splitter for card game",
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
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const RecentGames(),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GamesScreen()),
                        );
                      },
                      child: Row(
                        children: [
                          // Icon(Icons.play_circle_outline),
                          Icon(Icons.remove_red_eye),
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
                          'Players',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PlayersScreen()),
                            );
                          },
                          child: Text(
                            " Add / Edit Player",
                            // style: TextStyle(color: Colors.white),
                          ),
                          style: OutlinedButton.styleFrom(
                            // backgroundColor: Colors.redAccent,
                            side: BorderSide(width: 1.5, color: Colors.red),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15.0),
                    StreamBuilder<List<PlayerX>>(
                        stream: IsarService().getAllPlayers(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final players = snapshot.data;
                            if (players!.isEmpty) {
                              return Center(
                                  child: Column(
                                children: [
                                  Text('No Players added yet'),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PlayersScreen()),
                                      );
                                    },
                                    child: Text(
                                      " Add / Edit Player",
                                      // style: TextStyle(color: Colors.white),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      // backgroundColor: Colors.redAccent,
                                      side: BorderSide(
                                          width: 1.5, color: Colors.red),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                    ),
                                  ),
                                ],
                              ));
                            }

                            return Wrap(
                              spacing: 5.0,
                              children: players.map((PlayerX player) {
                                return FilterChip(
                                  label: Text(player.name),
                                  selected: _selected.contains(player),
                                  onSelected: (bool value) {
                                    //
                                  },
                                );
                              }).toList(),
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),
                    const SizedBox(height: 30.0),
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
