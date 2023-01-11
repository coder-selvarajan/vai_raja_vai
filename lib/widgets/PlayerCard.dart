import 'package:flutter/material.dart';
import '../models/model.dart';

class PlayerCard extends StatelessWidget {
  final Player player;
  const PlayerCard(this.player, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [Text(player.shortname), Text(player.name)],
    );
  }
}
