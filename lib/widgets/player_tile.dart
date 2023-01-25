import 'package:flutter/material.dart';

class PlayerTile extends StatelessWidget {
  final String name;
  final String shortname;
  final String color;

  const PlayerTile(
      {super.key,
      required this.name,
      required this.shortname,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // onLongPress: longPressCallback,
      leading: const CircleAvatar(
        backgroundColor: Colors.white,
        radius: 30.0,
        child: Icon(
          Icons.person,
          size: 30.0,
          color: Colors.orangeAccent,
        ),
      ),
      title: Text(
        "$shortname - $name",
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      trailing: const Icon(
        Icons.delete,
        size: 20.0,
        color: Colors.red,
      ),
    );
  }
}
