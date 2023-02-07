import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game.dart';
import '../models/isar_service.dart';
import '../screens/add_game_screen.dart';
import 'game_tile.dart';

class GamesList extends StatelessWidget {
  const GamesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return StreamBuilder<List<Game>>(
        stream: IsarService().streamGames(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final games = snapshot.data;
            if (games!.isEmpty) {
              return Center(
                  child: Column(
                children: [
                  Text('No Games added yet'),
                  SizedBox(
                    height: 30.0,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddGame()),
                      );
                    },
                    child: Text(
                      "New Game",
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
              ));
            }
            return ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: games.length,
              itemBuilder: (context, index) {
                final cutfor = games[index];
                if (index == 0) {
                  // return the header
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            Text(
                              "Games Played:",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Spacer(),
                            OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AddGame()),
                                );
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    " New Game",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                side: BorderSide(width: 1.5, color: Colors.red),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GameTile(game: cutfor),
                    ],
                  );
                }

                return GameTile(game: cutfor);
              },
              separatorBuilder: (_, id) => const Divider(
                color: Colors.black,
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
