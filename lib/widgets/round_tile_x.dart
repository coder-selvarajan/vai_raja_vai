import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vai_raja_vai/screens/edit_round_screen.dart';
import '../models/game.dart';

class RoundTileX extends StatelessWidget {
  GameX game;
  RoundX round;
  // final int roundno;
  // final List<RoundEntry> entries;
  // final DateTime time; // = DateTime.now();

  RoundTileX({
    super.key,
    required this.game,
    required this.round,
    // required this.roundno,
    // required this.entries,
    // required this.time,
  });

  String formatAmount(int amt) {
    if (amt == -1) {
      return "**";
    } else {
      return " $amt";
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return ListTile(
      // onLongPress: longPressCallback,
      leading: CircleAvatar(
        radius: 15.0,
        child: Text(
          round.roundNo.toString(),
          // style: textTheme.bodyMedium,
        ),
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('hh:mm a').format(round.time),
            // style: const TextStyle(fontWeight: FontWeight.bold),
            style: textTheme.bodyLarge,
          ),
          Text(
            round.entries
                .map((e) =>
                    "${e.player.toUpperCase().substring(0, 2)} ${formatAmount(e.toPay)}")
                .join(' - '),
            style: textTheme.bodyMedium,
          ),
          // const Text("took 5 mins.."),
        ],
      ),
      trailing: const Icon(
        Icons.chevron_right,
        size: 25.0,
        color: Colors.red,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EditRound(
                    round: round,
                    game: game,
                  )),
        );
      },
    );
  }
}
