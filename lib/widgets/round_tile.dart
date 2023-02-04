import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vai_raja_vai/models/model.dart';

class RoundTile extends StatelessWidget {
  final int roundno;
  final List<RoundEntry> entries;
  final DateTime time; // = DateTime.now();

  RoundTile({
    super.key,
    required this.roundno,
    required this.entries,
    required this.time,
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
    return ListTile(
      // onLongPress: longPressCallback,
      leading: CircleAvatar(
        child: Text(
          roundno.toString(),
        ),
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('hh:mm a').format(time),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            entries
                .map((p) => "${p.player.shortname}${formatAmount(p.toPay)}")
                .join(', '),
          ),
          const Text("took 5 mins.."),
        ],
      ),
      trailing: const Icon(
        Icons.delete,
        size: 20.0,
        color: Colors.red,
      ),
      // onTap: () {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => const RoundsScreen()),
      //   );
      // },
    );
  }
}
