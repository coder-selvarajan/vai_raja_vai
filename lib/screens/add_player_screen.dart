import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vai_raja_vai/models/isar_service.dart';
import 'package:vai_raja_vai/models/player.dart';

class AddPlayer extends StatelessWidget {
  final IsarService isarService;
  const AddPlayer({Key? key, required this.isarService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name = "";
    String shortname = "";
    String color = "FF0000";
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text("New Player"),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              // child: Form(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Who? ", style: textTheme.titleLarge),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true, //<-- SEE HERE
                        fillColor: Colors.grey.withOpacity(0.2),
                        hintText: "Enter the Player name",
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.person),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      onChanged: (value) {
                        name = value;
                        shortname = value.substring(0, 2);
                      },
                    ),
                    const SizedBox(height: 30.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        textStyle:
                            const TextStyle(fontSize: 20, color: Colors.white),
                        // shape: StadiumBorder(),
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(20.0)),
                      ),
                      // style: OutlinedButton.styleFrom(
                      //   side: BorderSide(width: 1.0, color: Colors.red),
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(20.0)),
                      // ),
                      onPressed: () {
                        if (name.isNotEmpty) {
                          isarService.savePlayer(PlayerX()..name = name);
                          Navigator.pop(context);
                        } else {
                          //no players are selected
                          //display alert here
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Invalid Input:'),
                              content: const Text(
                                  'Enter the player name and click Save'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                        // }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('Save Player'),
                      ),
                    ),
                  ],
                ),
              ),
              // ),
            ),
          ),
        ],
      ),
      // body: Container(
      //   color: const Color(0xff757575),
      //   child: Container(
      //     padding: const EdgeInsets.all(20.0),
      //     decoration: const BoxDecoration(
      //       color: Colors.white,
      //       borderRadius: BorderRadius.only(
      //         topLeft: Radius.circular(20.0),
      //         topRight: Radius.circular(20.0),
      //       ),
      //     ),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         Expanded(
      //           child: TextField(
      //             // obscureText: true,
      //             decoration: const InputDecoration(
      //               border: OutlineInputBorder(),
      //               hintText: "Enter player name..",
      //               labelText: ' NEW PLAYER ',
      //             ),
      //             autofocus: true,
      //             // textAlign: TextAlign.center,
      //             onChanged: (newText) {
      //               name = newText;
      //               shortname = newText.substring(0, 2);
      //             },
      //           ),
      //         ),
      //         Container(
      //           padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
      //           width: 100.0,
      //           height: 60.0,
      //           child: TextButton(
      //             style: TextButton.styleFrom(
      //               foregroundColor: Colors.white,
      //               padding: const EdgeInsets.all(8.0),
      //               backgroundColor: Colors.redAccent,
      //               textStyle: const TextStyle(fontSize: 18),
      //             ),
      //             child: const Text('Save'),
      //             onPressed: () {
      //               // Provider.of<PlayerData>(context)
      //               provider.addPlayer(name, shortname, color);
      //               Navigator.pop(context);
      //             },
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
