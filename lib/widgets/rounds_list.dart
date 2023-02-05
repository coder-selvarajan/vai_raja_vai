import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vai_raja_vai/widgets/round_tile.dart';

import '../models/game_data.dart';
import '../models/model.dart';
import '../screens/settlement_screen.dart';

class RoundsList extends StatelessWidget {
  // const RoundsList({Key? key}) : super(key: key);
  // final int cutforId;
  final Cutfor cutfor;

  const RoundsList({
    super.key,
    // required this.cutforId,
    required this.cutfor,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    var provider = Provider.of<GameData>(context);
    List<Round> roundsList = provider.getRounds(cutfor.id!);

    return Consumer<GameData>(
      builder: (context, gameData, child) {
        return ListView.separated(
          // scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: roundsList.length,
          itemBuilder: (context, index) {
            final round = roundsList[index];
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
                                  cutfor: cutfor,
                                  rounds: roundsList,
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
                  RoundTile(round: round),
                ],
              );
            }

            return RoundTile(round: round);
          },
          separatorBuilder: (_, id) => const Divider(
            color: Colors.black,
          ),
        );
      },
    );
  }
}
