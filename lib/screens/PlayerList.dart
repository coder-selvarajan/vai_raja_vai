import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vai_raja_vai/widgets/PlayerCard.dart';
import '../models/db_provider.dart';

class PlayerList extends StatelessWidget {
  const PlayerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (_, db, __) {
        var plList = db.players;
        return plList.isNotEmpty
            ? ListView.builder(
                itemCount: plList.length,
                itemBuilder: (_, i) => PlayerCard(plList[i]))
            : const Center(
                child: Text('No Players!'),
              );
      },
    );
  }
}
