import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vai_raja_vai/models/model.dart';
import 'package:vai_raja_vai/screens/players_screen.dart';
import 'package:vai_raja_vai/widgets/rounds_list.dart';

import '../models/game_data.dart';
import '../widgets/games_list.dart';
import 'add_game_screen.dart';

class RoundsScreen extends StatelessWidget {
  // const RoundsScreen({Key? key}) : super(key: key);
  final int cutforId;

  const RoundsScreen({
    super.key,
    required this.cutforId,
  });

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
              MaterialPageRoute(builder: (context) => const AddGame()),
            );
          }),
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Row(
          children: const [
            Icon(
              Icons.onetwothree,
              size: 45.0,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text("Game Info"),
            Spacer(),
            Icon(
              Icons.bar_chart_outlined,
              size: 40.0,
              color: Colors.white,
            ),
          ],
        ),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
                top: 30.0, left: 30.0, right: 30.0, bottom: 30.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.25),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: const [
                      Icon(
                        Icons.date_range,
                        size: 25.0,
                        color: Colors.redAccent,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Saturday, Jan-27  11:50 AM"),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: const [
                      Icon(
                        Icons.place_outlined,
                        size: 25.0,
                        color: Colors.redAccent,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Ramesh Home"),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: const [
                      Icon(
                        Icons.people,
                        size: 25.0,
                        color: Colors.redAccent,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("RA, MA, EL, MO, SI"),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: const [
                      Icon(
                        Icons.info_outline,
                        size: 25.0,
                        color: Colors.redAccent,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Ongoing.."),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
              ),
              child: RoundsList(cutforId: cutforId),
            ),
          ),
        ],
      ),
    );
  }
}
