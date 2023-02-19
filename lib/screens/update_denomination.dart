import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/isar_service.dart';
import '../models/setting.dart';

class UpdateDenomination extends StatefulWidget {
  UpdateDenomination({Key? key}) : super(key: key);
  Setting setting = Setting();
  List<int> denominations = List.empty(growable: true);

  @override
  State<UpdateDenomination> createState() => _UpdateDenominationState();
}

class _UpdateDenominationState extends State<UpdateDenomination> {
  final formKey = GlobalKey<FormState>();

  Future<void> fetchSettings() async {
    var temp = await IsarService().getSettings();
    // if (temp == null) {
    //   await IsarService().saveSetting(Setting());
    //   temp = await IsarService().getSettings();
    // }
    setState(() {
      widget.denominations = [...temp!.denominations];
      widget.setting = temp!;
    });
  }

  Future<void> saveSettings() async {
    widget.setting.denominations = widget.denominations;
    await IsarService().saveSetting(widget.setting);
    var temp = await IsarService().getSettings();

    setState(() {
      widget.denominations = [...temp!.denominations];
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

  void showMessage(String title, String msg) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(msg),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String newDenomination = "";
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
                      Icons.numbers_rounded,
                      size: 35.0,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Denomination Setup"),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  "Current denominations in order: \n(You may delete/add denominations here)"),
              const SizedBox(
                height: 15.0,
              ),
              Wrap(
                spacing: 5.0,
                // children: denominations.map((String dina) {
                children: widget.denominations.map((int deno) {
                  return Chip(
                    label: Text(" $deno "),
                    onDeleted: () {
                      if (deno == 0) {
                        showMessage("Cannot Delete '0'!",
                            "'0' denomination is required as a default value");
                      } else if (widget.denominations.length <= 2) {
                        // cant allow
                        showMessage('Cannot Delete! ',
                            'Atleast two denomination values should exist');
                      } else {
                        setState(() {
                          widget.denominations
                              .removeWhere((element) => element == deno);
                          // inputs = inputs - 1;
                        });
                        formKey.currentState?.reset();
                        // save to db
                        saveSettings();
                      }
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 10.0),
              Divider(
                color: Colors.grey,
                thickness: 1.0,
              ),
              const SizedBox(height: 10.0),
              const SizedBox(
                height: 10,
              ),
              Form(
                key: formKey,
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true, //<-- SEE HERE
                    fillColor: Colors.grey.withOpacity(0.2),
                    hintText: "Enter the new denomination  Eg: 100",
                    // prefixIcon: const Padding(
                    //   padding: EdgeInsets.all(8.0),
                    //   child: Icon(Icons.numbers),
                    // ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onChanged: (value) {
                    newDenomination = value;
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  textStyle: const TextStyle(fontSize: 20, color: Colors.white),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () {
                  if (newDenomination.isNotEmpty) {
                    if (widget.denominations
                            .where((element) =>
                                element.toString() ==
                                newDenomination.toString())
                            .length >
                        0) {
                      showMessage(
                          "Duplication!", "Denomination already exist.");
                    } else if (widget.denominations.length > 20) {
                      showMessage("Too Many Denominations!",
                          "You can't have more than 20 denominations. Delete some and add new ones.");
                    } else {
                      setState(() {
                        widget.denominations.add(int.parse(newDenomination));
                        widget.denominations.sort();
                        newDenomination = "0";
                      });
                      // save to db
                      saveSettings();
                      formKey.currentState?.reset();
                    }
                  } else {
                    //display alert here
                    showMessage("Invalid Input!",
                        "Enter the denomination and click Add");
                  }
                  // }
                },
                child: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text('Add Denomination'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
