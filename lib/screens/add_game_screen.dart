import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vai_raja_vai/models/model.dart';

import '../models/game_data.dart';

class AddGame extends StatefulWidget {
  const AddGame({Key? key}) : super(key: key);

  @override
  State<AddGame> createState() => _AddGameState();
}

class _AddGameState extends State<AddGame> {
  final List<Player> _selected = <Player>[];

  String place = "";
  DateTime gameTime = DateTime.now();
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(
      const Duration(microseconds: 5000),
      (Timer t) => setState(() {
        gameTime = DateTime.now();
      }),
    );

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

    // players = provider.players;

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
                title: const Text("New Game"),
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
          // physics: ScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Where ? ", style: textTheme.titleLarge),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true, //<-- SEE HERE
                        fillColor: Colors.grey.withOpacity(0.2),
                        hintText: "Enter the Place",
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.place_outlined),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      onChanged: (value) {
                        place = value;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Text('Who are all playing?',
                            style: textTheme.titleLarge),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text('(Tick them below)'),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    Wrap(
                      spacing: 5.0,
                      children: provider.players.map((Player player) {
                        return FilterChip(
                          label: Text(player.name),
                          selected: _selected.contains(player),
                          onSelected: (bool value) {
                            setState(() {
                              if (value) {
                                if (!_selected.contains(player)) {
                                  _selected.add(player);
                                }
                              } else {
                                _selected.removeWhere((Player filterPlayer) {
                                  return filterPlayer == player;
                                });
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                    // const SizedBox(height: 10.0),
                    // Text('Selected : ${_filters.join(', ')}'),
                    const SizedBox(height: 30.0),
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
                            .format(gameTime)),
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
                          provider.addCutfor(
                              _selected, place, gameTime, "created");
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
                        child: Text('Start Game'),
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
