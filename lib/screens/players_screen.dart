import 'package:flutter/material.dart';

import '../models/isar_service.dart';
import '../widgets/players_list.dart';
import 'add_player_screen.dart';

class PlayersScreen extends StatelessWidget {
  PlayersScreen({Key? key}) : super(key: key);

  final isarService = IsarService();

  @override
  Widget build(BuildContext context) {
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
                    Text("Players Info"),
                  ],
                ),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
              child: PlayersList(
                isarService: isarService,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
