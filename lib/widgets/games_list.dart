import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vai_raja_vai/widgets/game_tile.dart';
import '../models/game_data.dart';
import '../screens/add_game_screen.dart';

class GamesList extends StatelessWidget {
  const GamesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Consumer<GameData>(
      builder: (context, gameData, child) {
        return ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: gameData.gameCount,
          itemBuilder: (context, index) {
            final cutfor = gameData.games[index];
            if (index == 0) {
              // return the header
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
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
                          "Recent Games:",
                          style: textTheme.titleLarge,
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
                          child: Text(" + Add Game"),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GameTile(cutfor: cutfor),
                  // GameTile(
                  //     id: cutfor.id!,
                  //     place: cutfor.place,
                  //     players: cutfor.players,
                  //     time: cutfor.time),
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
