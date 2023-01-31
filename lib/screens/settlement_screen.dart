import 'dart:async';
// import 'dart:html';
// import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/game_data.dart';
import '../models/model.dart';

class SettlementScreen extends StatefulWidget {
  final Cutfor cutfor;
  final List<Round> rounds;
  const SettlementScreen({Key? key, required this.cutfor, required this.rounds})
      : super(key: key);

  @override
  State<SettlementScreen> createState() => _SettlementScreenState();
}

class SettlementInfo {
  late Player fromPlayer;
  late Player toPlayer;
  late int toPay;

  SettlementInfo(
      {Key? key,
      required this.fromPlayer,
      required this.toPlayer,
      required this.toPay});
}

class PlayerStatus {
  final Player player;
  late int gainlossAmount;
  // final Player? toPlayer;
  // final int toPay;

  PlayerStatus({
    Key? key,
    required this.player,
    required this.gainlossAmount,
    // this.toPlayer,
    // required this.toPay
  });
}

class _SettlementScreenState extends State<SettlementScreen> {
  DateTime roundTime = DateTime.now();
  late List<String> selectedValue = [];
  late List<PlayerStatus> playerStatuses = [];
  late List<SettlementInfo> settlementInfoList = [];

  @override
  void initState() {
    selectedValue = widget.cutfor.players.map((e) => "0").toList();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void processSettlement() {
    //get gain/loss
    playerStatuses = [];
    for (var i = 0; i < widget.cutfor.players.length; i++) {
      var str = getGainLoss(widget.cutfor.players[i]);
    }

    List<PlayerStatus> gainList = [
      ...playerStatuses.where((element) => element.gainlossAmount > 0).toList()
    ];
    gainList.sort((a, b) => a.gainlossAmount.compareTo(b.gainlossAmount));

    List<PlayerStatus> lossList = [
      ...playerStatuses.where((element) => element.gainlossAmount < 0).toList()
    ];
    lossList.sort((a, b) => b.gainlossAmount.compareTo(a.gainlossAmount));

    for (var j = 0; j < gainList.length; j++) {
      int gainAmt = gainList[j].gainlossAmount;
      for (var k = 0; k < lossList.length; k++) {
        int lossAmt = lossList[k].gainlossAmount;
        print("$gainAmt - $lossAmt");
        if (gainAmt == 0 || lossAmt == 0) {
          continue;
        }

        if (gainAmt >= lossAmt) {
          settlementInfoList.add(SettlementInfo(
              fromPlayer: lossList[k].player,
              toPlayer: gainList[j].player,
              toPay: gainAmt + lossAmt));

          gainList[j].gainlossAmount = gainAmt + lossAmt;
          gainAmt = gainList[j].gainlossAmount;
          lossList[k].gainlossAmount = 0;
          lossAmt = 0;
        } else {
          settlementInfoList.add(SettlementInfo(
              fromPlayer: lossList[k].player,
              toPlayer: gainList[j].player,
              toPay: lossAmt + gainAmt));

          lossList[k].gainlossAmount = lossAmt + gainAmt;
          lossAmt = lossList[k].gainlossAmount;
          gainList[j].gainlossAmount = 0;
          gainAmt = 0;
        }
      }
    }
  }

  String getGainLoss(Player player) {
    int totalAmt = 0;
    int winner2get = 0;
    int player2Pay = 0;
    bool playerWon = false;

    for (var i = 0; i < widget.rounds.length; i++) {
      for (var j = 0; j < widget.rounds[i].entries.length; j++) {
        if (widget.rounds[i].entries[j].toPay != -1) {
          winner2get += widget.rounds[i].entries[j].toPay;
        }
        if (widget.rounds[i].entries[j].player == player) {
          if (widget.rounds[i].entries[j].toPay == -1) {
            playerWon = true;
          } else {
            playerWon = false;
            player2Pay = widget.rounds[i].entries[j].toPay;
          }
        }
      }
      if (playerWon) {
        totalAmt += winner2get;
        playerWon = false;
      } else {
        totalAmt -= player2Pay;
      }
      winner2get = 0;
    }
    playerStatuses.add(PlayerStatus(player: player, gainlossAmount: totalAmt));
    return (totalAmt < 0) ? totalAmt.toString() : "+$totalAmt";
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    var provider = Provider.of<GameData>(context);
    var timeNow = DateTime.now();
    processSettlement();

    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text("Money Settlement"),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: 2000,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              // child: Form(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 40, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.date_range,
                                size: 25.0,
                                color: Colors.redAccent,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(DateFormat('EEEE MMMd, hh:mm a')
                                  .format(widget.cutfor.time)),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.place_outlined,
                                size: 25.0,
                                color: Colors.redAccent,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(widget.cutfor.place!),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.people,
                                size: 25.0,
                                color: Colors.redAccent,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(widget.cutfor.players
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
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: const [
                        Text(
                          "Gain / Loss : ",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      spacing: 5.0,
                      // children: widget.cutfor.players.map((Player player) {
                      children: playerStatuses.map((PlayerStatus playerStatus) {
                        return FilterChip(
                          label: Text(
                            "${playerStatus.player.name} ${playerStatus.gainlossAmount}",
                            style: textTheme.subtitle1,
                          ),
                          selected: false,
                          onSelected: (bool value) {
                            //   setState(() {
                            //     if (value) {
                            //       if (!_selected.contains(player)) {
                            //         _selected.add(player);
                            //       }
                            //     } else {
                            //       _selected.removeWhere((Player filterPlayer) {
                            //         return filterPlayer == player;
                            //       });
                            //     }
                            //   });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Colors.grey[300],
                      thickness: 3.0,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Who pays whom?: ",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      // itemCount: widget.cutfor.players.length,
                      itemCount: settlementInfoList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 50,
                          padding: EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "${settlementInfoList[index].fromPlayer.name} -> ${settlementInfoList[index].toPlayer.name} = Rs ${settlementInfoList[index].toPay}",
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (_, id) => const Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: Colors.red,
                    //     textStyle:
                    //         const TextStyle(fontSize: 20, color: Colors.white),
                    //   ),
                    //   onPressed: () {
                    //     //
                    //   },
                    //   child: const Padding(
                    //     padding: EdgeInsets.all(18.0),
                    //     child: Text('Mark as Settled'),
                    //   ),
                    // ),
                  ],
                ),
              ),
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
