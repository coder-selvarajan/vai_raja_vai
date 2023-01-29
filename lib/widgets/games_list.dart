import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vai_raja_vai/widgets/game_tile.dart';
import '../models/game_data.dart';

class GamesList extends StatelessWidget {
  const GamesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Consumer<GameData>(
      builder: (context, gameData, child) {
        return ListView.separated(
          scrollDirection: Axis.vertical,
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
                  Text(
                    "Recent Games",
                    style: textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GameTile(
                      id: cutfor.id!,
                      place: cutfor.place,
                      players: cutfor.players,
                      time: cutfor.time),
                ],
              );
            }

            return GameTile(
                id: cutfor.id!,
                place: cutfor.place,
                players: cutfor.players,
                time: cutfor.time);
          },
          separatorBuilder: (_, id) => const Divider(
            color: Colors.black,
          ),
        );
      },
    );
  }
}
