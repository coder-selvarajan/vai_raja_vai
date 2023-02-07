import 'package:flutter/material.dart';
import 'package:vai_raja_vai/models/isar_service.dart';
import 'package:vai_raja_vai/models/player.dart';
import 'package:vai_raja_vai/screens/add_player_screen.dart';
import 'package:vai_raja_vai/screens/games_screen.dart';
import 'package:vai_raja_vai/screens/players_screen.dart';
import 'package:vai_raja_vai/widgets/recent_games.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Player> _selected = <Player>[];
  int playersCount = 0;

  Future<void> getPlayersCount() async {
    playersCount = await IsarService().getPlayersCount();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    getPlayersCount();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120), //height of appbar
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
                        const SizedBox(
                          height: 2,
                        ),
                        const Text(
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
        physics: const ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                    RecentGames(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Divider(
                      color: Colors.grey.withOpacity(0.3),
                      thickness: 1.0,
                    ),
                    const SizedBox(height: 10.0),
                    StreamBuilder<List<Player>>(
                        stream: IsarService().streamPlayers(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final players = snapshot.data;
                            if (players!.isEmpty) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'No Players Yet!',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text("Add atleast two players"),
                                      ],
                                    ),
                                    const Spacer(),
                                    OutlinedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PlayersScreen()),
                                        );
                                      },
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: Colors.redAccent,
                                        side: const BorderSide(
                                            width: 1.5, color: Colors.red),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                      ),
                                      child: const Text(
                                        "Goto Players",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.people,
                                        size: 30.0,
                                        color: Colors.red,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        'Current Players',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Spacer(),
                                      OutlinedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PlayersScreen()),
                                          );
                                        },
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor: Colors.redAccent,
                                          side: const BorderSide(
                                              width: 1.5, color: Colors.red),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                        ),
                                        child: const Text(
                                          "Edit Players",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15.0),
                                  Wrap(
                                    spacing: 5.0,
                                    children: players.map((Player player) {
                                      return FilterChip(
                                        label: Text(player.name),
                                        selected: _selected.contains(player),
                                        onSelected: (bool value) {
                                          //
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
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
