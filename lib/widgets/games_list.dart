import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vai_raja_vai/widgets/game_tile.dart';
import '../models/game_data.dart';

class GamesList extends StatelessWidget {
  const GamesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameData>(
      builder: (context, gameData, child) {
        return ListView.builder(
          itemCount: gameData.gameCount,
          itemBuilder: (context, index) {
            final cutfor = gameData.games[index];
            return Column(
              children: [
                GameTile(
                    place: cutfor.place,
                    players: cutfor.players,
                    time: cutfor.time),
                const Divider(
                  color: Colors.black,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
