import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/game.dart';
import '../models/isar_service.dart';

List<String> amountList = <String>['Win', '0', '20', '40', '80'];

class EditRound extends StatefulWidget {
  final Game game;
  final Round round;
  const EditRound({Key? key, required this.round, required this.game})
      : super(key: key);

  @override
  State<EditRound> createState() => _EditRoundState();
}

class _EditRoundState extends State<EditRound> {
  late List<String> selectedValue = [];

  @override
  void initState() {
    selectedValue = widget.round.entries
        .map((e) => (e.toPay == -1 ? "Win" : e.toPay.toString()))
        .toList();
    super.initState();
  }

  @override
  void dispose() {
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
                title: const Text("Edit Round"),
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
                          Text("Round No: ${widget.round.roundNo}",
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
                                  .format(widget.round.time)),
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
                      itemCount: widget.round.entries.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 45,
                          padding: EdgeInsets.all(2.0),
                          child: Center(
                            child: Row(
                              children: [
                                Text(
                                  widget.round.entries[index].player,
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
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                      onPressed: () {
                        if (selectedValue
                                .where((element) => element == "Win")
                                .length ==
                            1) {
                          List<RoundEntry> entries = [];
                          for (var i = 0;
                              i < widget.round.entries.length;
                              i++) {
                            entries.add(RoundEntry()
                              ..player = widget.round.entries[i].player
                              ..toPay = int.parse((selectedValue[i] == "Win"
                                  ? "-1"
                                  : selectedValue[i])));
                          }
                          // provider.editRound(widget.round.id!, entries);
                          List<Round> rounds = [...widget.game.rounds!];
                          for (int i = 0; i < rounds.length; i++) {
                            if (rounds[i] == widget.round) {
                              rounds[i].entries = entries;
                            }
                          }
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
                        child: Text('Update Round'),
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
