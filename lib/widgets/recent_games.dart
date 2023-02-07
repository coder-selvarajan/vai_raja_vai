import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vai_raja_vai/widgets/game_tile.dart';
import '../models/game.dart';
import '../models/isar_service.dart';
import '../screens/add_game_screen.dart';
import '../screens/games_screen.dart';

class RecentGames extends StatelessWidget {
  RecentGames({Key? key}) : super(key: key);
  int pCount = 0;

  Future<void> getPlayerCount() async {
    pCount = await IsarService().getPlayersCount();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return StreamBuilder<List<Game>>(
        stream: IsarService().streamRecentGames(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final games = snapshot.data;
            if (games!.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "No Games Played Yet!",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("Click 'New Game' to create"),
                      ],
                    ),
                    Spacer(),
                    OutlinedButton(
                      onPressed: () async {
                        await getPlayerCount();
                        if (pCount > 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddGame()),
                          );
                        } else {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Prerequisite'),
                              content: const Text(
                                  'You need atleast two players to create a game'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        side: BorderSide(width: 1.5, color: Colors.red),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      child: const Text(
                        "New Game",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        // style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Column(
              children: [
                ListView.separated(
                  padding: EdgeInsets.only(bottom: 10.0, left: 0.0, right: 0.0),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: games.length,
                  itemBuilder: (context, index) {
                    final game = games[index];
                    if (index == 0) {
                      // return the header
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.currency_rupee,
                                  size: 30.0,
                                  color: Colors.red,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "Recent Games",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                OutlinedButton(
                                  onPressed: () async {
                                    await getPlayerCount();
                                    if (pCount > 1) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AddGame()),
                                      );
                                    } else {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text('Prerequisite'),
                                          content: const Text(
                                              'You need atleast two players to create a game'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'OK'),
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
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
                                    "New Game",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          GameTile(game: game),
                        ],
                      );
                    }

                    return GameTile(game: game);
                  },
                  separatorBuilder: (_, id) => const Divider(
                    color: Colors.black,
                  ),
                ),
                (games.length >= 3
                    ? OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const GamesScreen()),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side:
                              const BorderSide(width: 1.0, color: Colors.white),
                        ),
                        child: Row(
                          children: const [
                            // Icon(Icons.play_circle_outline),
                            Icon(Icons.remove_red_eye),
                            SizedBox(
                              width: 10,
                            ),
                            Text(" View All Games"),
                          ],
                        ),
                      )
                    : const SizedBox()),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
