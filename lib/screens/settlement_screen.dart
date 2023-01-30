import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/game_data.dart';
import '../models/model.dart';

class SettlementScreen extends StatefulWidget {
  final Cutfor cutfor;

  const SettlementScreen({Key? key, required this.cutfor}) : super(key: key);

  @override
  State<SettlementScreen> createState() => _SettlementScreenState();
}

class _SettlementScreenState extends State<SettlementScreen> {
  DateTime roundTime = DateTime.now();
  late Timer _timer;
  late List<String> selectedValue = [];

  @override
  void initState() {
    _timer = Timer.periodic(
      const Duration(microseconds: 5000),
      (Timer t) => setState(() {
        roundTime = DateTime.now();
      }),
    );
    selectedValue = widget.cutfor.players.map((e) => "0").toList();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    var provider = Provider.of<GameData>(context);
    var timeNow = DateTime.now();

    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text("Money Settlement"),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: 2000,
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
                padding: const EdgeInsets.fromLTRB(10, 40, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.date_range,
                                size: 25.0,
                                color: Colors.redAccent,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(DateFormat('EEEE MMMd, hh:mm a')
                                  .format(widget.cutfor.time)),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.place_outlined,
                                size: 25.0,
                                color: Colors.redAccent,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(widget.cutfor.place!),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.people,
                                size: 25.0,
                                color: Colors.redAccent,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(widget.cutfor.players
                                  .map((p) => p.shortname.toString())
                                  .join(", ")),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.info_outline,
                                size: 25.0,
                                color: Colors.redAccent,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Ongoing.."),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Text("Entries: ", style: textTheme.titleLarge),
                        Spacer(),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: widget.cutfor.players.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 60,
                          padding: EdgeInsets.all(10.0),
                          child: Center(
                            child: Row(
                              children: [
                                Text(
                                  widget.cutfor.players[index].name,
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_, id) => const Divider(
                        color: Colors.grey,
                        thickness: 1.0,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        textStyle:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () {
                        //
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Text('Mark as Settled'),
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
    );
  }
}
