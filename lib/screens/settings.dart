import 'package:flutter/material.dart';
import 'package:vai_raja_vai/screens/edit_autocomplete_screen.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> denominations = ["0", "10", "20", "40", "80"];

    final TextTheme textTheme = Theme.of(context).textTheme;

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
                      Icons.settings,
                      size: 35.0,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Settings"),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.build_circle_outlined,
                    size: 25.0,
                    color: Colors.red,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Denomination Setup",
                    style: TextStyle(
                      fontSize: textTheme.titleMedium!.fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      side: const BorderSide(width: 1.5, color: Colors.red),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                    child: const Text(
                      "Update",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
                "Below denominations are used while making entries for players in each round of a game."),
            const SizedBox(
              height: 15.0,
            ),
            Wrap(
              spacing: 5.0,
              children: denominations.map((String dina) {
                return Chip(
                  label: Text(" $dina ",
                      style: TextStyle(
                        fontSize: textTheme.titleMedium!.fontSize,
                        fontWeight: FontWeight.w500,
                      )),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.grey,
              thickness: 1.0,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.build_circle_outlined,
                    size: 25.0,
                    color: Colors.red,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Game Auto-ending",
                    style: TextStyle(
                      fontSize: textTheme.titleMedium!.fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditAutocomplete()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      side: const BorderSide(width: 1.5, color: Colors.red),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                    child: const Text(
                      "Change",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ListTile(
              horizontalTitleGap: 15,
              contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
              title: const Text(
                  "Games will automatically be marked as 'Ended' after :"),
              trailing: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  "2 hours",
                  style: TextStyle(
                    // color: Colors.red.shade700,
                    fontSize: textTheme.titleMedium!.fontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
