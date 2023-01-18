import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vai_raja_vai/widgets/PlayerCard.dart';
import 'package:vai_raja_vai/widgets/PlayerInput.dart';
import '../models/db_provider.dart';

class PlayerListOld extends StatelessWidget {
  const PlayerListOld({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Player List"),
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, db, child) {
          var plList = db.players;
          return plList.isNotEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PlayerInput()),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('New Player'),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: plList.length,
                          itemBuilder: (_, i) => PlayerCard(plList[i])),
                    ),
                  ],
                )
              : const Center(
                  child: Text('No Players!'),
                );
        },
      ),
    );
  }
}
