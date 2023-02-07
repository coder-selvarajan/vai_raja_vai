import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/game.dart';
import '../models/isar_service.dart';

List<String> amountList = <String>['Win', '0', '20', '40', '80'];

class AddRound extends StatefulWidget {
  final Game game;
  final int roundNo;
  const AddRound({Key? key, required this.game, required this.roundNo})
      : super(key: key);

  @override
  State<AddRound> createState() => _AddRoundState();
}

class _AddRoundState extends State<AddRound> {
  DateTime roundTime = DateTime.now();
  late Timer _timer;
  late List<String> selectedValue = [];

  @override
  void initState() {
    _timer = Timer.periodic(
      const Duration(microseconds: 5000),
      (Timer t) => setState(() {
        roundTime = DateTime.now();
      }),
    );
    selectedValue = widget.game.players.map((e) => "0").toList();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    // var provider = Provider.of<GameData>(context);
    var timeNow = DateTime.now();

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
                title: const Text("New Round"),
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
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 20),
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
                          Text("Round No: ${widget.roundNo}",
                              style: textTheme.headline6),
                          const SizedBox(height: 5.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.date_range,
                                color: Colors.red,
                                size: 25.0,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(DateFormat('EEEE, MMM-dd  -  hh:mm a')
                                  .format(roundTime)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Text("Entries: ", style: textTheme.titleMedium),
                        Spacer(),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.separated(
                      padding: EdgeInsets.only(bottom: 10.0),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.game.players.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 45,
                          padding: EdgeInsets.all(2.0),
                          child: Center(
                            child: Row(
                              children: [
                                Text(
                                  widget.game.players[index],
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 12, top: 0, bottom: 0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DropdownButton<String>(
                                    underline: SizedBox(),
                                    value: selectedValue[index],
                                    iconSize: 30,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    onChanged: (String? value) {
                                      setState(() {
                                        selectedValue[index] = value!;
                                      });
                                    },
                                    items: amountList
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_, id) => const Divider(
                        color: Colors.grey,
                        thickness: 1.0,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        textStyle:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () {
                        if (true) {
                          List<RoundEntry> entries = [];
                          for (var i = 0; i < widget.game.players.length; i++) {
                            entries.add(RoundEntry()
                              ..player = widget.game.players[i]
                              ..toPay = int.parse((selectedValue[i] == "Win"
                                  ? "-1"
                                  : selectedValue[i])));

                            // RoundEntry(
                            // roundNo: widget.roundNo,
                            // player: widget.game.players[i],
                            // toPay: int.parse((selectedValue[i] == "Win"
                            //     ? "-1"
                            //     : selectedValue[i])))

                          }

                          List<Round> rounds = (widget.game.rounds == null
                              ? List.empty(growable: true)
                              : [...widget.game.rounds!]);
                          rounds.add(Round()
                            ..time = roundTime
                            ..roundNo = widget.roundNo
                            ..entries = entries);

                          widget.game.rounds = rounds;
                          IsarService().saveGame(widget.game);

                          // provider.addRound(
                          //     widget.game.id!, entries, widget.roundNo);
                          Navigator.pop(context);
                        } else {
                          //no players are selected
                          //display alert here
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Invalid Input:'),
                              content: const Text(
                                  'Enter the place & Select atleast two players'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                        // }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('Save Round'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
