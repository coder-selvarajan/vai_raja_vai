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
                  Row(
                    children: [
                      // const Icon(
                      //   Icons.onetwothree,
                      //   size: 45.0,
                      //   color: Colors.redAccent,
                      // ),
                      Text(
                        "Rounds:",
                        style: textTheme.titleLarge,
                      ),
                      Spacer(),
                      OutlinedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red[500],
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
                            children: [
                              const Icon(
                                Icons.currency_rupee_sharp,
                                size: 20.0,
                                color: Colors.white,
                              ),
                              Text(' Settlement',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                  )),
                            ],
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  RoundTile(
                      roundno: round.roundNo,
                      time: round.time,
                      entries: round.entries),
                ],
              );
            }

            return RoundTile(
                roundno: round.roundNo,
                time: round.time,
                entries: round.entries);
          },
          separatorBuilder: (_, id) => const Divider(
            color: Colors.black,
          ),
        );
      },
    );
  }
}
