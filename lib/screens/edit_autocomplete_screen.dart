import 'package:flutter/material.dart';

import '../models/isar_service.dart';
import '../models/setting.dart';

List<String> hours = <String>['2 hours', '4 hours', '6 hours', '10 hours'];
List<int> hoursInt = <int>[2, 4, 6, 10];

class EditAutocomplete extends StatefulWidget {
  EditAutocomplete({Key? key}) : super(key: key);

  Setting setting = Setting();
  int autoClosureHour = 2;
  String _selectedHour = '2 hours';

  @override
  State<EditAutocomplete> createState() => _EditAutocompleteState();
}

class _EditAutocompleteState extends State<EditAutocomplete> {
  Future<void> fetchSettings() async {
    var temp = await IsarService().getSettings();
    if (temp == null) {
      await IsarService().saveSetting(Setting());
      temp = await IsarService().getSettings();
    }
    setState(() {
      widget.autoClosureHour = temp!.autoClosureHours;
      widget._selectedHour = widget.autoClosureHour.toString() + " hours";
      widget.setting = temp!;
    });
  }

  Future<void> saveSettings() async {
    widget.setting.autoClosureHours = widget.autoClosureHour;
    await IsarService().saveSetting(widget.setting);
    var temp = await IsarService().getSettings();

    setState(() {
      widget.autoClosureHour = temp!.autoClosureHours;
      widget.setting = temp!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (mounted) {
      fetchSettings();
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
                  children: [
                    Icon(
                      Icons.settings,
                      size: 35.0,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Game Auto-ending"),
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
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              // child: Form(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                        "Games should automatically be marked as 'Ended' after:  ",
                        style: textTheme.subtitle1),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 12, top: 0, bottom: 0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.15),
                      ),
                      child: DropdownButton<String>(
                        underline: SizedBox(),
                        value: widget._selectedHour,
                        iconSize: 40,
                        // iconEnabledColor: Colors.red,
                        isExpanded: true,
                        onChanged: (String? value) {
                          if (value is String) {
                            setState(() {
                              widget._selectedHour = value;
                              widget.autoClosureHour =
                                  int.parse(value.replaceAll(" hours", ""));
                            });
                          }
                        },
                        items:
                            hours.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Row(
                              children: [
                                Text(
                                  value,
                                  style: textTheme.titleMedium,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        textStyle:
                            const TextStyle(fontSize: 20, color: Colors.white),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                      onPressed: () {
                        if (widget._selectedHour.isNotEmpty) {
                          // save to db
                          saveSettings();
                          Navigator.pop(context);
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text('Update Setting'),
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
