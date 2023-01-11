import 'package:flutter/material.dart';

class PlayerInput extends StatelessWidget {
  const PlayerInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: Row(
        children: [
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: const TextField(),
          )),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {},
            child: Container(
              color: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: const Text('Add'),
            ),
          )
        ],
      ),
    );
  }
}
