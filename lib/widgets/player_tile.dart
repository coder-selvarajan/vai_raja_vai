import 'package:flutter/material.dart';
import 'package:vai_raja_vai/screens/edit_player_screen.dart';

import '../models/model.dart';

class PlayerTile extends StatelessWidget {
  final Player player;
  // final String name;
  // final String shortname;

  const PlayerTile({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // onLongPress: longPressCallback,
      leading: CircleAvatar(
        backgroundColor: Colors.grey.withOpacity(0.4),
        // radius: 30.0,
        child: Text(
          player.shortname,
          style: TextStyle(color: Colors.black),
        ),
      ),
      title: Text(
        player.name,
        // style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      // trailing: const Icon(
      //   Icons.edit_rounded,
      //   size: 20.0,
      //   color: Colors.black12,
      // ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditPlayer(
              player: player,
            ),
          ),
        );
      },
    );
  }
}
