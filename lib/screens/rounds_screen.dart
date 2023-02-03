import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vai_raja_vai/models/model.dart';
import 'package:vai_raja_vai/screens/add_round_screen.dart';
import 'package:vai_raja_vai/screens/players_screen.dart';
import 'package:vai_raja_vai/screens/settlement_screen.dart';
import 'package:vai_raja_vai/widgets/rounds_list.dart';

import '../models/game_data.dart';
import '../widgets/games_list.dart';
import 'add_game_screen.dart';

class RoundsScreen extends StatelessWidget {
  final Cutfor cutfor;

  const RoundsScreen({
    super.key,
    required this.cutfor,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    var provider = Provider.of<GameData>(context);
    List<Round> rounds = provider.getRounds(cutfor.id!);

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.redAccent,
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddRound(
                  currentCutfor: cutfor,
                  roundNo: rounds.length + 1,
                ),
              ),
            );
          }),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80), //height of appbar
        child: Container(
          color: Colors.redAccent,
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.redAccent,
                title: Row(
                  children: const [
                    Icon(
                      Icons.onetwothree,
                      size: 45.0,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Game Info"),
                    // Spacer(),
                    // InkWell(
                    //   child: Icon(
                    //     Icons.bar_chart_outlined,
                    //     size: 40.0,
                    //     color: Colors.white,
                    //   ),
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => SettlementScreen(
                    //           cutfor: cutfor,
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),
                  ],
                ),
                elevation: 0,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 30.0, right: 30.0, bottom: 20.0),
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Icon(
                            Icons.date_range,
                            size: 25.0,
                            color: Colors.redAccent,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(DateFormat('EEEE MMMd, hh:mm a')
                              .format(cutfor.time)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.place_outlined,
                            size: 25.0,
                            color: Colors.redAccent,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(cutfor.place!),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.people,
                            size: 25.0,
                            color: Colors.redAccent,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(cutfor.players
                              .map((p) => p.shortname.toString())
                              .join(", ")),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.info_outline,
                            size: 25.0,
                            color: Colors.redAccent,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Ongoing.."),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Expanded(
              //   child: Container(
              Container(
                padding: EdgeInsets.all(20.0),
                child: RoundsList(cutfor: cutfor),
              ),
              // ),
            ],
          ),
        );
      }),
    );
  }
}
