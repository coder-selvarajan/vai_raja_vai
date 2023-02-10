import 'package:flutter/material.dart';
import 'package:vai_raja_vai/screens/edit_player_screen.dart';
import '../models/player.dart';

class PlayerTile extends StatelessWidget {
  final Player player;
  // final String name;
  // final String shortname;

  const PlayerTile({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // onLongPress: longPressCallback,
      contentPadding: EdgeInsets.all(0.0),
      leading: CircleAvatar(
        // backgroundColor: Colors.grey.withOpacity(0.4),
        backgroundColor: Colors.redAccent,
        // radius: 30.0,
        child: Text(
          player.name.toUpperCase().substring(0, 2),
          style: TextStyle(color: Colors.white),
        ),
      ),
      title: Text(
        player.name,
        // style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        size: 30.0,
        color: Colors.red,
      ),
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
