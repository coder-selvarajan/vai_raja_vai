import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vai_raja_vai/models/model.dart';

import '../models/game_data.dart';

class AddGame extends StatefulWidget {
  const AddGame({Key? key}) : super(key: key);

  @override
  State<AddGame> createState() => _AddGameState();
}

class _AddGameState extends State<AddGame> {
  final List<Player> _selected = <Player>[
    Player(id: 2, name: "Elango", shortname: "EL", color: "00FF00"),
    Player(id: 3, name: "Manikkam", shortname: "MA", color: "0000FF"),
  ];

  final List<Player> players = [
    Player(id: 1, name: "Ramesh", shortname: "RA", color: "FF0000"),
    Player(id: 2, name: "Elango", shortname: "EL", color: "00FF00"),
    Player(id: 3, name: "Manikkam", shortname: "MA", color: "0000FF"),
    Player(id: 4, name: "Siva", shortname: "SI", color: "FF0000"),
    Player(id: 5, name: "Natarajan", shortname: "NA", color: "0000FF"),
  ];

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    // String place = "";
    // List<Player> currentPlayers = [];
    // DateTime time = DateTime.now();

    var provider = Provider.of<GameData>(context);

    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: const Text("New Game"),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
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
                    const Text(
                        "Enter the place and select players to create a game"),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true, //<-- SEE HERE
                        fillColor: Colors.grey.withOpacity(0.2),
                        hintText: "Place of the game?",
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
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Choose Players :', style: textTheme.labelLarge),
                    const SizedBox(height: 5.0),
                    Wrap(
                      spacing: 5.0,
                      children: players.map((Player player) {
                        // ExerciseFilter.values.map((ExerciseFilter exercise) {
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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        textStyle:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () {
                        provider.addCutfor(
                            _selected, "Gobi Home", DateTime.now());
                        Navigator.pop(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Text('Create Game'),
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
