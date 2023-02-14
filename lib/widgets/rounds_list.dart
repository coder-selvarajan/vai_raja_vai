import 'package:flutter/material.dart';
import 'package:vai_raja_vai/models/game.dart';
import 'package:vai_raja_vai/widgets/round_tile.dart';
import '../screens/settlement_screen.dart';

class RoundsList extends StatelessWidget {
  final Game game;

  const RoundsList({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ListView.separated(
      // scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: (game.rounds == null ? 0 : game.rounds!.length),
      itemBuilder: (context, index) {
        final round = game.rounds![index];
        if (index == 0) {
          // return the header
          return Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rounds Played:",
                        style: TextStyle(
                            fontSize: textTheme.titleMedium!.fontSize,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "(Click on the round to edit)",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Spacer(),
                  // OutlinedButton(
                  //   style: OutlinedButton.styleFrom(
                  //     side: BorderSide(width: 1.0, color: Colors.white),
                  //   ),
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => SettlementScreen(
                  //           game: game,
                  //         ),
                  //       ),
                  //     );
                  //   },
                  //   child: Row(
                  //     children: [Icon(Icons.arrow_upward)],
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              RoundTile(
                round: round,
                game: game,
              ),
            ],
          );
        }

        return RoundTile(
          round: round,
          game: game,
        );
      },
      separatorBuilder: (_, id) => const Divider(
        color: Colors.black,
      ),
    );
  }
}
