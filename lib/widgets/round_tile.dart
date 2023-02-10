import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vai_raja_vai/screens/edit_round_screen.dart';
import '../models/game.dart';

class RoundTile extends StatelessWidget {
  Game game;
  Round round;
  // final int roundno;
  // final List<RoundEntry> entries;
  // final DateTime time; // = DateTime.now();

  RoundTile({
    super.key,
    required this.game,
    required this.round,
    // required this.roundno,
    // required this.entries,
    // required this.time,
  });

  String formatAmount(int amt) {
    if (amt == -1) {
      return "";
    } else {
      return "";
      // return "-$amt";
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return ListTile(
      // onLongPress: longPressCallback,
      contentPadding: EdgeInsets.all(0.0),
      horizontalTitleGap: 10.0,
      leading: CircleAvatar(
        radius: 15.0,
        child: Text(
          round.roundNo.toString(),
          // style: textTheme.bodyMedium,
        ),
        backgroundColor: Colors.red.shade600,
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

          Wrap(
            children: round.entries.map((RoundEntry re) {
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${re.player.toUpperCase().substring(0, 2)}${formatAmount(re.toPay)}",
                      style: TextStyle(
                        fontSize: textTheme.bodyMedium?.fontSize,
                        fontWeight: re.toPay == -1
                            ? FontWeight.w700
                            : FontWeight.normal,
                        color:
                            re.toPay == -1 ? Colors.green[700] : Colors.black87,
                      ),
                    ),
                    (re.toPay == -1
                        ? Icon(
                            Icons.star_border,
                            size: 15.0,
                            color: Colors.green.shade700,
                          )
                        : Text("-${re.toPay}")),
                  ],
                ),
              );
            }).toList(),
          ),
          // Text(
          //   round.entries
          //       .map((e) =>
          //           "${e.player.toUpperCase().substring(0, 2)} ${formatAmount(e.toPay)}")
          //       .join(' - '),
          //   style: textTheme.bodyMedium,
          // ),
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
