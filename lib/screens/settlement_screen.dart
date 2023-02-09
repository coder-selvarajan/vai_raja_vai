import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vai_raja_vai/models/game.dart';

class SettlementScreen extends StatefulWidget {
  final Game game;
  const SettlementScreen({Key? key, required this.game}) : super(key: key);

  @override
  State<SettlementScreen> createState() => _SettlementScreenState();
}

class SettlementInfo {
  late String fromPlayer;
  late String toPlayer;
  late int toPay;

  SettlementInfo(
      {Key? key,
      required this.fromPlayer,
      required this.toPlayer,
      required this.toPay});
}

class PlayerStatus {
  final String player;
  late int gainlossAmount;
  late int gainlossAmount2;
  // final Player? toPlayer;
  // final int toPay;

  PlayerStatus({
    Key? key,
    required this.player,
    required this.gainlossAmount,
    required this.gainlossAmount2,
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
    selectedValue = widget.game.players.map((e) => "0").toList();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void processSettlement() {
    //get gain/loss
    playerStatuses = [];
    for (var i = 0; i < widget.game.players.length; i++) {
      var str = getGainLoss(widget.game.players[i]);
    }
    playerStatuses.sort((a, b) => b.gainlossAmount.compareTo(a.gainlossAmount));

    List<PlayerStatus> gainList = [
      ...playerStatuses.where((element) => element.gainlossAmount > 0).toList()
    ];
    gainList.sort((a, b) => a.gainlossAmount.compareTo(b.gainlossAmount));

    List<PlayerStatus> lossList = [
      ...playerStatuses.where((element) => element.gainlossAmount < 0).toList()
    ];
    lossList.sort((a, b) => b.gainlossAmount.compareTo(a.gainlossAmount));

    settlementInfoList = [];
    for (var j = 0; j < gainList.length; j++) {
      int gainAmt = gainList[j].gainlossAmount2;
      for (var k = 0; k < lossList.length; k++) {
        int lossAmt = lossList[k].gainlossAmount2;
        // print("$gainAmt - $lossAmt");
        if (gainAmt == 0 || lossAmt == 0) {
          continue;
        }

        if (gainAmt >= -lossAmt) {
          settlementInfoList.add(SettlementInfo(
              fromPlayer: lossList[k].player,
              toPlayer: gainList[j].player,
              toPay: -lossAmt));

          gainList[j].gainlossAmount2 = gainAmt + lossAmt;
          gainAmt = gainList[j].gainlossAmount2;
          lossList[k].gainlossAmount2 = 0;
          lossAmt = 0;
        } else {
          settlementInfoList.add(SettlementInfo(
              fromPlayer: lossList[k].player,
              toPlayer: gainList[j].player,
              toPay: gainAmt));

          lossList[k].gainlossAmount2 = lossAmt + gainAmt;
          lossAmt = lossList[k].gainlossAmount2;
          gainList[j].gainlossAmount2 = 0;
          gainAmt = 0;
        }
      }
    }

    settlementInfoList.sort((a, b) => b.toPay.compareTo(a.toPay));
  }

  String getGainLoss(String player) {
    int totalAmt = 0;
    int winner2get = 0;
    int player2Pay = 0;
    bool playerWon = false;

    for (var i = 0; i < widget.game.rounds!.length; i++) {
      for (var j = 0; j < widget.game.rounds![i].entries.length; j++) {
        if (widget.game.rounds![i].entries[j].toPay != -1) {
          winner2get += widget.game.rounds![i].entries[j].toPay;
        }
        if (widget.game.rounds![i].entries[j].player == player) {
          if (widget.game.rounds![i].entries[j].toPay == -1) {
            playerWon = true;
          } else {
            playerWon = false;
            player2Pay = widget.game.rounds![i].entries[j].toPay;
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
    playerStatuses.add(PlayerStatus(
        player: player, gainlossAmount: totalAmt, gainlossAmount2: totalAmt));
    return (totalAmt < 0) ? totalAmt.toString() : "+$totalAmt";
  }

  String formatAmount(int amount) {
    if (amount > 0) {
      return "+$amount";
    }
    return amount.toString();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    var timeNow = DateTime.now();
    processSettlement();

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
                title: const Text("Money Settlement"),
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
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 30),
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
                                    .format(widget.game.time)),
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
                                Text(widget.game.place!),
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
                                Text(
                                    "Status: ${describeEnum(widget.game.status!)}"),
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
                        children:
                            playerStatuses.map((PlayerStatus playerStatus) {
                          return FilterChip(
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${playerStatus.player}",
                                  style: textTheme.subtitle2,
                                ),
                                Text(
                                    " ${formatAmount(playerStatus.gainlossAmount)}",
                                    style: TextStyle(
                                        fontSize: textTheme.subtitle2!.fontSize,
                                        color: playerStatus.gainlossAmount >= 0
                                            ? Colors.green.shade700
                                            : Colors.red.shade800,
                                        fontWeight:
                                            playerStatus.gainlossAmount >= 0
                                                ? FontWeight.w700
                                                : FontWeight.w500)),
                              ],
                            ),
                            selected: false,
                            onSelected: (bool value) {
                              //
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
                        physics: NeverScrollableScrollPhysics(),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  settlementInfoList[index].fromPlayer,
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Icon(
                                    Icons.arrow_right_alt_sharp,
                                    color: Colors.redAccent,
                                    size: 22.0,
                                  ),
                                ),
                                Text(
                                  settlementInfoList[index].toPlayer,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                Spacer(),
                                const Icon(
                                  Icons.currency_rupee_sharp,
                                  size: 20.0,
                                  // color: Colors.white,
                                ),
                                Text(
                                  "${settlementInfoList[index].toPay}",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (_, id) => SizedBox(
                          height: 10.0,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
