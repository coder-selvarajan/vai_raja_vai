import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vai_raja_vai/models/game.dart';
import 'package:vai_raja_vai/screens/rounds_screen.dart';

import '../models/game_data.dart';
import '../models/model.dart';

class GameTileX extends StatelessWidget {
  final GameX cutfor;
  // final int id;
  // final String? place;
  // final List<Player> players;
  // final DateTime time; // = DateTime.now();

  GameTileX({
    super.key,
    required this.cutfor,
    // required this.id,
    // required this.place,
    // required this.players,
    // required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // onLongPress: longPressCallback,
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('EE MMMd').format(cutfor.time),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            DateFormat('hh:mm a').format(cutfor.time),
          ),
        ],
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cutfor.place!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          // Text("Started @ " + DateFormat('hh:mm a').format(time)),
          Text(cutfor.players
              .map((name) => name.substring(0, 2).toUpperCase())
              .join(', ')),
          Text(cutfor.status.toString()),
        ],
      ),
      trailing: const Icon(
        Icons.chevron_right,
        size: 30.0,
        color: Colors.red,
      ),
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => RoundsScreen(cutfor: cutfor)),
        // );
      },
    );
  }
}
