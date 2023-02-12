import 'dart:ui';

import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      Icons.info_outline,
                      size: 35.0,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("About the App"),
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
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "வை ராஜா வை (Vai Raja Vai)",
              style: TextStyle(fontSize: textTheme.titleLarge!.fontSize),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
                "It's a simple money splitter app for card game played among friends and family. It takes entries like who won the round and who pays what for each round of a game and then it quickly run thru the entries and generate a report of gain/loss and the details of money split among the players."),
            SizedBox(
              height: 20,
            ),
            Text(
                "Notes: It's a free app(ad-free too) and it does n't require internet connectivity or access to any of the information from the phone. "),
            SizedBox(
              height: 20,
            ),
            Text("Technologies used: Flutter & Isar Local DB"),
            SizedBox(
              height: 20,
            ),
            Text("More details: https://apps.selvarajan.in"),
          ],
        ),
      ),
    );
  }
}
