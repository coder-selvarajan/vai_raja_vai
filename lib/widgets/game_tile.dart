import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vai_raja_vai/models/game.dart';
import '../screens/rounds_screen.dart';

class GameTile extends StatelessWidget {
  Game game;

  GameTile({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ListTile(
      // horizontalTitleGap: 20.0,
      contentPadding: EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0),
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
          ),
          Text(
            DateFormat('EE MMMd').format(game.time),
            style: TextStyle(
                fontSize: textTheme.caption!.fontSize,
                // fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          // const SizedBox(
          //   height: 5,
          // ),
          // Text(
          //   DateFormat('MMMd').format(game.time),
          //   style: TextStyle(
          //       fontSize: textTheme.caption!.fontSize,
          //       fontWeight: FontWeight.bold,
          //       color: Colors.black87),
          // ),
          // const SizedBox(
          //   height: 5,
          // ),
          Text(
            DateFormat('hh:mm a  ').format(game.time),
            style: TextStyle(
                fontSize: textTheme.caption!.fontSize, color: Colors.black87),
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
            // style: textTheme.titleLarge,
            // style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Text(
            game.players
                .map((name) => name.substring(0, 2).toUpperCase())
                .join(', '),
            style: textTheme.subtitle2,
          ),
          Row(
            children: [
              Text(
                (game.rounds == null
                        ? "Game "
                        : (game.rounds!.length == 1
                            ? "${game.rounds!.length} Round, Game "
                            : "${game.rounds!.length} Rounds, Game ")) +
                    describeEnum(game.status!),
                style: textTheme.bodySmall,
              ),
              const SizedBox(
                width: 5.0,
              ),
              (game.status! == Status.Ongoing
                  ? const Icon(
                      Icons.circle_rounded,
                      color: Colors.green,
                      size: 10.0,
                    )
                  : SizedBox()),
            ],
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
