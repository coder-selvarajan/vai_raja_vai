import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vai_raja_vai/models/player_data.dart';
import 'package:vai_raja_vai/widgets/player_tile.dart';

class PlayersList extends StatelessWidget {
  const PlayersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerData>(
      builder: (context, playerData, child) {
        return ListView.builder(
          itemCount: playerData.playerCount,
          itemBuilder: (context, index) {
            final player = playerData.Players[index];
            return PlayerTile(
              name: player.name,
              shortname: player.shortname,
              color: player.color,
            );
          },
        );
      },
    );
  }
}
