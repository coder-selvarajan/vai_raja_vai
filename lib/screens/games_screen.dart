import 'package:flutter/material.dart';
import 'package:vai_raja_vai/screens/add_game_screen.dart';
import 'package:vai_raja_vai/screens/players_screen.dart';
import 'package:vai_raja_vai/widgets/games_list.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({Key? key}) : super(key: key);

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

            // showModalBottomSheet(
            //     context: context,
            //     isScrollControlled: true,
            //     builder: (context) => SingleChildScrollView(
            //             child: Container(
            //           padding: EdgeInsets.only(
            //               bottom: MediaQuery.of(context).viewInsets.bottom),
            //           child: const AddGame(),
            //         )));
          }),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
                top: 50.0, left: 30.0, right: 30.0, bottom: 30.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.auto_awesome,
                  size: 40.0,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 20.0,
                ),
                const Text(
                  'Cutfors',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30.0,
                  child: IconButton(
                    icon: const Icon(
                      Icons.people,
                      size: 30.0,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PlayersScreen()),
                      );
                    },
                  ),
                ),
                // Text(
                //   '5 Players',
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 18,
                //   ),
                // ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: const GamesList(),
            ),
          ),
        ],
      ),
    );
  }
}
