import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/model.dart';

class GameTile extends StatelessWidget {
  final String? place;
  final List<Player> players;
  final DateTime time; // = DateTime.now();

  GameTile({
    super.key,
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            DateFormat.MMMd().format(time),
          ),
          Text(
            DateFormat.EEEE().format(time),
          ),
        ],
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            place!,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          ),
          const Text("2:05pm - 3:15pm"),
          Text(players.map((p) => p.shortname).join(',')),
        ],
      ),
      trailing: const Icon(
        Icons.delete,
        size: 20.0,
        color: Colors.red,
      ),
    );
  }
}
