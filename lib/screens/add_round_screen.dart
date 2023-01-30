import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/game_data.dart';
import '../models/model.dart';

List<String> amountList = <String>['-1', '0', '20', '40', '80'];

class AddRound extends StatefulWidget {
  final Cutfor currentCutfor;
  final int roundNo;
  // final List<Player> players;
  const AddRound({Key? key, required this.currentCutfor, required this.roundNo})
      : super(key: key);

  @override
  State<AddRound> createState() => _AddRoundState();
}

class _AddRoundState extends State<AddRound> {
  // final List<Player> _selected = <Player>[];

  // String place = "";
  DateTime roundTime = DateTime.now();
  late Timer _timer;
  // List<String> dropdownValue = [
  //   amountList.first,
  //   amountList.first,
  //   amountList.first,
  //   amountList.first
  // ];

  late List<String> selectedValue = [];

  @override
  void initState() {
    _timer = Timer.periodic(
      const Duration(microseconds: 5000),
      (Timer t) => setState(() {
        roundTime = DateTime.now();
      }),
    );

    selectedValue = widget.currentCutfor.players.map((e) => "0").toList();

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

    var provider = Provider.of<GameData>(context);
    var timeNow = DateTime.now();

    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text("New Round"),
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
                          Text("Round No: ${widget.roundNo}",
                              style: textTheme.headline5),
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.date_range,
                                color: Colors.red,
                                size: 30.0,
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
                      height: 30,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Text("Entries: ", style: textTheme.titleLarge),
                        Spacer(),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: widget.currentCutfor.players.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 60,
                          padding: EdgeInsets.all(10.0),
                          child: Center(
                            child: Row(
                              children: [
                                Text(
                                  widget.currentCutfor.players[index].name,
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 12, top: 0, bottom: 0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 2),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DropdownButton<String>(
                                    underline: SizedBox(),
                                    value: selectedValue[index],
                                    iconSize: 36,
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
                          for (var i = 0;
                              i < widget.currentCutfor.players.length;
                              i++) {
                            entries.add(RoundEntry(
                                roundNo: widget.roundNo,
                                player: widget.currentCutfor.players[i],
                                toPay: int.parse(selectedValue[i])));
                          }

                          provider.addRound(widget.currentCutfor.id!, entries,
                              widget.roundNo);
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
                        padding: EdgeInsets.all(18.0),
                        child: Text('Save Round'),
                      ),
                    ),
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
