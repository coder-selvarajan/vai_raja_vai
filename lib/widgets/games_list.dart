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
          itemCount: gameData.playerCount,
          itemBuilder: (context, index) {
            final player = gameData.players[index];
            return Column(
              children: [
                GameTile(),
                const Divider(
                  color: Colors.black,
                ),
              ],
            );
            // return PlayerTile(
            //   name: player.name,
            //   shortname: player.shortname,
            //   color: player.color,
            // );
          },
        );
      },
    );
  }
}
