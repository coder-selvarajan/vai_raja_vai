import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vai_raja_vai/widgets/game_tile.dart';
import '../models/game_data.dart';
import '../screens/add_game_screen.dart';

class RecentGames extends StatelessWidget {
  const RecentGames({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Consumer<GameData>(
      builder: (context, gameData, child) {
        return ListView.separated(
          padding: EdgeInsets.only(bottom: 10.0, left: 0, right: 0),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: gameData.games.length > 3 ? 3 : gameData.games.length,
          itemBuilder: (context, index) {
            final cutfor = gameData.games[index];
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
                  GameTile(cutfor: cutfor),
                ],
              );
            }

            return GameTile(cutfor: cutfor);
          },
          separatorBuilder: (_, id) => const Divider(
            color: Colors.black,
          ),
        );
      },
    );
  }
}
