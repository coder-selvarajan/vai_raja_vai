import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vai_raja_vai/models/game.dart';
import '../screens/rounds_screen.dart';

class GameTile extends StatelessWidget {
  final Game game;

  GameTile({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('EE MMMd').format(game.time),
            style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            DateFormat('hh:mm a').format(game.time),
            style: const TextStyle(fontSize: 13.0, color: Colors.black87),
          ),
          Spacer(),
        ],
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            game.place!,
            // style: textTheme.titleMedium,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Text(
            game.players
                .map((name) => name.substring(0, 2).toUpperCase())
                .join(', '),
            style: textTheme.subtitle2,
          ),
          Text(
            (game.rounds == null
                    ? ""
                    : (game.rounds!.length == 1
                        ? "${game.rounds!.length} round, "
                        : "${game.rounds!.length} rounds, ")) +
                describeEnum(game.status!),
            style: textTheme.bodyMedium,
          ),
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
              builder: (context) => RoundsScreen(
                    // game: game,
                    gameId: game.id,
                  )),
        );
      },
    );
  }
}
