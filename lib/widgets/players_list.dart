import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vai_raja_vai/models/game_data.dart';
import 'package:vai_raja_vai/screens/add_player_screen.dart';
import 'package:vai_raja_vai/screens/edit_player_screen.dart';
import 'package:vai_raja_vai/widgets/player_tile.dart';

class PlayersList extends StatelessWidget {
  const PlayersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameData>(
      builder: (context, gameData, child) {
        return ListView.separated(
          itemCount: gameData.playerCount,
          itemBuilder: (context, index) {
            final player = gameData.players[index];
            if (index == 0) {
              // return the header
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "All Players",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Click on the player to edit"),
                          ],
                        ),
                        Spacer(),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddPlayer()),
                            );
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.person_add_alt_1,
                                size: 20.0,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Add Player"),
                            ],
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(width: 1.5, color: Colors.red),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PlayerTile(
                    player: player,
                  ),
                ],
              );
            }

            return PlayerTile(player: player);
          },
          separatorBuilder: (_, id) => const Divider(
            color: Colors.black,
          ),
        );
      },
    );
  }
}
