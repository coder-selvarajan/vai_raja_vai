import 'package:flutter/material.dart';

import '../widgets/players_list.dart';
import 'add_player_screen.dart';

class PlayersScreen extends StatelessWidget {
  const PlayersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.redAccent,
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddPlayer()),
            );
            // showModalBottomSheet(
            //   context: context,
            //   isScrollControlled: true,
            //   builder: (context) => SingleChildScrollView(
            //     child: Container(
            //       padding: EdgeInsets.only(
            //           bottom: MediaQuery.of(context).viewInsets.bottom),
            //       child: const AddPlayer(),
            //     ),
            //   ),
            // );
          }),
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Row(
          children: const [
            Icon(
              Icons.people,
              size: 25.0,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text("Players"),
          ],
        ),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: const PlayersList(),
            ),
          ),
        ],
      ),
    );
  }
}
