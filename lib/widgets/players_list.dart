import 'package:flutter/material.dart';
import 'package:vai_raja_vai/models/player.dart';
import 'package:vai_raja_vai/screens/add_player_screen.dart';
import 'package:vai_raja_vai/widgets/player_tile.dart';
import '../models/isar_service.dart';

class PlayersList extends StatelessWidget {
  const PlayersList({Key? key, required this.isarService}) : super(key: key);

  final IsarService isarService;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Player>>(
        stream: isarService.streamPlayers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final players = snapshot.data;
            if (players!.isEmpty) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "No Players Yet!",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddPlayer(
                                isarService: isarService,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.person_add_alt_1,
                              size: 20.0,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Add Player",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          side: BorderSide(width: 1.5, color: Colors.red),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              );
            }
            return ListView.separated(
              // itemCount: gameData.playerCount,
              itemCount: players.length,
              itemBuilder: (context, index) {
                // final player = gameData.players[index];
                final player = players[index];
                if (index == 0) {
                  // return the header
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
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
                                  builder: (context) => AddPlayer(
                                    isarService: isarService,
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.person_add_alt_1,
                                  size: 20.0,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Add Player",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              side: BorderSide(width: 1.5, color: Colors.red),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                            ),
                          ),
                        ],
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
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
