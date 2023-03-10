import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/game.dart';
import '../models/isar_service.dart';

class AddRound extends StatefulWidget {
  final Game game;
  final int roundNo;
  final List<String> amountList;

  AddRound(
      {Key? key,
      required this.game,
      required this.roundNo,
      required this.amountList})
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
                padding: const EdgeInsets.fromLTRB(25, 5, 25, 20),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Entries: ", style: textTheme.titleLarge),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Make sure to choose a winner and the appropriate amounts to be paid for others",
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
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
                                    items: widget.amountList
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
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                      onPressed: () {
                        //check if there is a winner
                        if (selectedValue
                                .where((element) => element == "Win")
                                .length ==
                            1) {
                          List<RoundEntry> entries = [];
                          for (var i = 0; i < widget.game.players.length; i++) {
                            entries.add(RoundEntry()
                              ..player = widget.game.players[i]
                              ..toPay = int.parse((selectedValue[i] == "Win"
                                  ? "-1"
                                  : selectedValue[i])));
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

                          Navigator.pop(context);
                        } else {
                          //no players are selected
                          //display alert here
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Invalid Input!'),
                              content: const Text('There should be one winner'),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
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
                        padding: EdgeInsets.all(15.0),
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
