import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vai_raja_vai/models/game_data.dart';

class AddPlayer extends StatelessWidget {
  const AddPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name = "";
    String shortname = "";
    String color = "FF0000";

    var provider = Provider.of<GameData>(context);

    return Container(
      color: const Color(0xff757575),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                // obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter player name..",
                  labelText: ' NEW PLAYER ',
                ),
                autofocus: true,
                // textAlign: TextAlign.center,
                onChanged: (newText) {
                  name = newText;
                  shortname = newText.substring(0, 2);
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
              width: 100.0,
              height: 60.0,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(8.0),
                  backgroundColor: Colors.redAccent,
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Save'),
                onPressed: () {
                  // Provider.of<PlayerData>(context)
                  provider.addPlayer(name, shortname, color);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
