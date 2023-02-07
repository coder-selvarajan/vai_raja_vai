import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vai_raja_vai/models/game.dart';
import 'package:vai_raja_vai/widgets/round_tile_x.dart';
import '../screens/settlement_screen.dart';

class RoundsListX extends StatelessWidget {
  final GameX game;

  const RoundsListX({
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
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    // const Icon(
                    //   Icons.onetwothree,
                    //   size: 45.0,
                    //   color: Colors.redAccent,
                    // ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rounds Played:",
                          // style: textTheme.titleMedium,
                          style: TextStyle(fontWeight: FontWeight.bold),
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
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 1.0, color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettlementScreen(
                              game: game,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [Icon(Icons.arrow_upward)],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              RoundTileX(
                round: round,
                game: game,
              ),
            ],
          );
        }

        return RoundTileX(
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
