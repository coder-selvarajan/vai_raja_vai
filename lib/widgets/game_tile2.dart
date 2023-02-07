import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vai_raja_vai/models/game.dart';
import '../screens/rounds_screen_x.dart';

class GameTileX extends StatelessWidget {
  final GameX game;
  // final int id;
  // final String? place;
  // final List<Player> players;
  // final DateTime time; // = DateTime.now();

  GameTileX({
    super.key,
    required this.game,
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
            DateFormat('EE MMMd').format(game.time),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            DateFormat('hh:mm a').format(game.time),
          ),
        ],
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            game.place!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          // Text("Started @ " + DateFormat('hh:mm a').format(time)),
          Text(game.players
              .map((name) => name.substring(0, 2).toUpperCase())
              .join(', ')),
          Text(describeEnum(game.status!)),
        ],
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
              builder: (context) => RoundsScreenX(
                    // game: game,
                    gameId: game.id,
                  )),
        );
      },
    );
  }
}
