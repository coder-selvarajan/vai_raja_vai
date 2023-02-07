import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vai_raja_vai/widgets/game_tile2.dart';
import '../models/game.dart';
import '../models/isar_service.dart';
import '../screens/add_game_screen.dart';

class RecentGames extends StatelessWidget {
  const RecentGames({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return StreamBuilder<List<GameX>>(
        stream: IsarService().getRecentGames(),
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
              padding: EdgeInsets.only(bottom: 10.0, left: 0, right: 0),
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
                      Row(
                        children: [
                          Icon(
                            Icons.currency_rupee,
                            size: 30.0,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Recent Games",
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
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GameTileX(game: game),
                    ],
                  );
                }

                return GameTileX(game: game);
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
