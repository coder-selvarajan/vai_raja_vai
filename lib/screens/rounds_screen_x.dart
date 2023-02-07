import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:vai_raja_vai/models/isar_service.dart';
import 'package:vai_raja_vai/screens/settlement_screen.dart';
import 'package:vai_raja_vai/widgets/rounds_list_x.dart';
import '../models/game.dart';
import 'add_round_screen_x.dart';

class RoundsScreenX extends StatelessWidget {
  // final Cutfor cutfor;
  final Id gameId;
  // late Stream<GameX?> game = IsarService().getGame(gameId);

  RoundsScreenX({
    super.key,
    // required this.game,
    required this.gameId,
  });

  // Future<void> fetchGame() async {
  //   print("fetchGame() called...");
  //   // game = (await IsarService().getGame(gameId))!;
  // }

  @override
  Widget build(BuildContext context) {
    // GameX game = fetchGame() as GameX;
    final TextTheme textTheme = Theme.of(context).textTheme;
    // fetchGame();

    // var provider = Provider.of<GameData>(context);
    // List<Round> rounds = provider.getRounds(cutfor.id!);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80), //height of appbar
        child: Container(
          color: Colors.redAccent,
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.redAccent,
                title: Row(
                  children: [
                    Icon(
                      Icons.onetwothree,
                      size: 45.0,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Game Info"),
                    Spacer(),
                    InkWell(
                      child: Icon(
                        Icons.delete_outline_outlined,
                        size: 40.0,
                        color: Colors.white,
                      ),
                      onTap: () {
                        //
                      },
                    ),
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
      body: StreamBuilder<List<GameX>>(
          stream: IsarService().getGame(gameId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final game = snapshot.data?.first;
              if (game == null) {
                return Center(child: Text('Game is not found'));
              }
              return SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 30.0, right: 30.0, bottom: 10.0),
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
                                    .format(game.time)),
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
                                Text(game.place!),
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
                                Expanded(
                                  child: Text(
                                    game.players.map((name) => name).join(", "),
                                    softWrap: true,
                                    // maxLines: 1,
                                    // overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.check_circle_outline,
                                  size: 25.0,
                                  color: Colors.redAccent,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Game ${describeEnum(game.status!)}"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Expanded(
                    //   child: Container(
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (game.status! == Status.Progressing)
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                        width: 1.5, color: Colors.red),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddRoundX(
                                          game: game,
                                          roundNo: (game.rounds == null
                                                  ? 0
                                                  : game.rounds!.length) +
                                              1,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text(' + Add Round',
                                          style: TextStyle(
                                              // fontSize: 18.0,
                                              // color: Colors.white,
                                              )),
                                    ],
                                  ),
                                ),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side:
                                      BorderSide(width: 1.5, color: Colors.red),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SettlementScreen(game: game),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.currency_rupee_sharp,
                                      size: 20.0,
                                      // color: Colors.white,
                                    ),
                                    Text(' View Settlement',
                                        style: TextStyle(
                                            // fontSize: 18.0,
                                            // color: Colors.white,
                                            )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          RoundsListX(
                            game: game,
                          ),
                        ],
                      ),
                    ),
                    // ),
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
