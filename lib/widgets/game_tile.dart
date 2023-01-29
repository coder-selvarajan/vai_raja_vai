import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vai_raja_vai/screens/rounds_screen.dart';

import '../models/model.dart';

class GameTile extends StatelessWidget {
  final int id;
  final String? place;
  final List<Player> players;
  final DateTime time; // = DateTime.now();

  GameTile({
    super.key,
    required this.id,
    required this.place,
    required this.players,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // onLongPress: longPressCallback,
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            DateFormat('EE MMMd').format(time),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            DateFormat('hh:mm a').format(time),
          ),
        ],
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            place!,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          ),
          // Text("Started @ " + DateFormat('hh:mm a').format(time)),
          Text(players.map((p) => p.shortname).join(', ')),
          const Text("Played for 1hr"),
        ],
      ),
      trailing: const Icon(
        Icons.delete,
        size: 20.0,
        color: Colors.red,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RoundsScreen(cutforId: id)),
        );
      },
    );
  }
}
