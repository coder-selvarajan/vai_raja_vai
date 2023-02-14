import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  Future<void> _launchUrl(Uri _url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

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
            const SizedBox(
              height: 20,
            ),
            const Text(
                "A simple money splitter app for card game played among friends. It takes entries like who won and who pays what etc.. for each round and calculates the money split-up at the end of the game."),
            const SizedBox(
              height: 20,
            ),
            const Text(
                "It's an ad free app. It does n't require internet connectivity or access to any of the information from the user's phone."),
            const SizedBox(
              height: 20,
            ),
            const Text("Technologies used: Flutter & Isar Local DB"),
            const SizedBox(
              height: 20,
            ),
            const Text("Developer website : https://selvarajan.in"),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Image/Icon Attribution:",
              style: TextStyle(
                  fontSize: textTheme.titleSmall!.fontSize,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              child: Text(
                'Playing cards icons created by Hilmy Abiyyu A. - Flaticon',
                style: textTheme.caption,
              ),
              onTap: () async {
                final Uri _url = Uri.parse(
                    'https://www.flaticon.com/free-icons/playing-cards');
                _launchUrl(_url);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              child: Text(
                'Rupee icons created by YI-PIN - Flaticon',
                style: textTheme.caption,
              ),
              onTap: () async {
                final Uri _url =
                    Uri.parse('https://www.flaticon.com/free-icons/rupee');
                _launchUrl(_url);
              },
            ),
          ],
        ),
      ),
    );
  }
}
