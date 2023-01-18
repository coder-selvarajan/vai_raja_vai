import 'package:flutter/material.dart';

import '../screens/PlayerListOld.dart';

class PlayerInput extends StatelessWidget {
  const PlayerInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Player List"),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                child: const TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    icon: Icon(
                      Icons.person_add_alt_1,
                      color: Colors.blue,
                    ),
                    hintText: 'Enter Player Name',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PlayerListOld()),
                  );
                },
                child: const Text('Save Player'),
              ),
            ],
          )

          // Row(
          //   children: [
          //     Expanded(
          //         child: Container(
          //       padding: const EdgeInsets.symmetric(horizontal: 5),
          //       child: const TextField(),
          //     )),
          //     const SizedBox(width: 10),
          //     GestureDetector(
          //       onTap: () {},
          //       child: Container(
          //         color: Colors.red,
          //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          //         child: const Text('Add'),
          //       ),
          //     )
          //   ],
          // ),
          ),
    );
  }
}
