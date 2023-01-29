import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/game_data.dart';
import '../models/model.dart';

List<String> amountList = <String>['Win', '0', '20', '40', '80'];

class AddRound extends StatefulWidget {
  const AddRound({Key? key}) : super(key: key);

  @override
  State<AddRound> createState() => _AddRoundState();
}

class _AddRoundState extends State<AddRound> {
  final List<Player> _selected = <Player>[];

  String place = "";
  DateTime roundTime = DateTime.now();
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(
      const Duration(microseconds: 5000),
      (Timer t) => setState(() {
        roundTime = DateTime.now();
      }),
    );

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String dropdownValue = amountList.first;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    var provider = Provider.of<GameData>(context);
    var timeNow = DateTime.now();

    // players = provider.players;

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
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Round No: 2", style: textTheme.titleLarge),
                    const SizedBox(height: 10.0),
                    Row(
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
                    const Divider(
                      color: Colors.black,
                    ),
                    Text("Entries: "),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text('Ramesh'),
                            Spacer(),
                            DropdownButton<String>(
                              value: dropdownValue,
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  dropdownValue = value!;
                                });
                              },
                              items: amountList.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Elango'),
                            Spacer(),
                            Text('20'),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Manikkam'),
                            Spacer(),
                            Text('20'),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Muhusamy'),
                            Spacer(),
                            Text('20'),
                          ],
                        )
                      ],
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
                        if (place.isNotEmpty && _selected.length > 1) {
                          provider.addCutfor(_selected, place, roundTime);
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
                        child: Text('Save'),
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
