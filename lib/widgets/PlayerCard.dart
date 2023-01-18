import 'package:flutter/material.dart';
import '../models/model.dart';

class PlayerCard extends StatelessWidget {
  final Player player;
  const PlayerCard(this.player, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        // onLongPress: longPressCallback,
        leading: const Padding(
            padding: EdgeInsets.all(2.0),
            child: Icon(Icons.person,
                color: Colors.green) //Text(player.shortname),
            ),
        title: Text(
          player.name,
          style: const TextStyle(color: Colors.blue),
        ),
        subtitle: Text(player.shortname),
        // trailing: Checkbox(
        //   activeColor: Colors.lightBlueAccent,
        //   value: isChecked,
        //   onChanged: checkboxCallback,
        // ),
      ),
    );

    //   Container(
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //     children: [
    //       Text(
    //         player.shortname,
    //         style: const TextStyle(fontSize: 15.0),
    //       ),
    //       Text(
    //         player.name,
    //         style: const TextStyle(fontSize: 15.0),
    //       )
    //     ],
    //   ),
    // );
  }
}
