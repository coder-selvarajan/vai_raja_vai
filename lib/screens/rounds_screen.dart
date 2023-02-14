import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:vai_raja_vai/models/isar_service.dart';
import 'package:vai_raja_vai/screens/settlement_screen.dart';
import 'package:vai_raja_vai/widgets/rounds_list.dart';
import '../models/game.dart';
import 'add_round_screen.dart';

class RoundsScreen extends StatelessWidget {
  // final Cutfor cutfor;
  final Id gameId;
  // late Stream<GameX?> game = IsarService().getGame(gameId);

  RoundsScreen({
    super.key,
    // required this.game,
    required this.gameId,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

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
                    const Icon(
                      Icons.manage_search,
                      size: 35.0,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text("Game Info, Rounds"),
                    const Spacer(),
                    InkWell(
                      child: const Icon(
                        Icons.delete_rounded,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      onTap: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Delete Game'),
                            content:
                                const Text('Are you sure to delete this game?'),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  IsarService().deleteGame(gameId);
                                  Navigator.pop(context);
                                  Navigator.pop(context, "OK");
                                },
                                child: const Text('Yes, Delete'),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                            ],
                          ),
                        );
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
      body: StreamBuilder<List<Game>>(
          stream: IsarService().getGameById(gameId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == null) return SizedBox();
              final game = snapshot.data?.first;
              if (game == null) {
                return Center(child: Text('Game is not found'));
              }
              return SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        // padding: const EdgeInsets.only(
                        //     top: 10.0, left: 30.0, right: 30.0, bottom: 10.0),
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
                                      game.players
                                          .map((name) => name)
                                          .join(", "),
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
                                  Row(
                                    children: [
                                      Text(
                                          "Game ${describeEnum(game.status!)}"),
                                      SizedBox(
                                        width: 5,
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
                            ],
                          ),
                        ),
                      ),
                      // Expanded(
                      //   child: Container(
                      Container(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                if (game.status! == Status.Ongoing)
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.redAccent,
                                      side: BorderSide(
                                          width: 1.5, color: Colors.red),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                    ),
                                    onPressed: () async {
                                      var temp =
                                          await IsarService().getSettings();

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddRound(
                                            game: game,
                                            roundNo: (game.rounds == null
                                                    ? 0
                                                    : game.rounds!.length) +
                                                1,
                                            amountList: [
                                              'Win',
                                              ...temp!.denominations
                                                  .map((e) => e.toString())
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons.add,
                                          size: 20.0,
                                          color: Colors.white,
                                          // color: Colors.white,
                                        ),
                                        Text(
                                          ' Add Round',
                                          style: TextStyle(
                                            // fontSize: 18.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.redAccent,
                                    side: BorderSide(
                                        width: 1.5, color: Colors.red),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                  ),
                                  onPressed: () {
                                    if (game.rounds != null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SettlementScreen(game: game),
                                        ),
                                      );
                                    }
                                  },
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.currency_rupee_sharp,
                                        size: 20.0,
                                        color: Colors.white,
                                        // color: Colors.white,
                                      ),
                                      Text(' View Settlement',
                                          style: TextStyle(
                                            // fontSize: 18.0,
                                            color: Colors.white,
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            RoundsList(
                              game: game,
                            ),
                          ],
                        ),
                      ),
                      // ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
