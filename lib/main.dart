import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_midi_command/flutter_midi_command_messages.dart';

void main() => runApp(const MyApp());

var darkMode = false;
var globalFontSize = 35;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class ButtonMeta {
  String buttonName;
  int buttonVal;
  CCMessage button;
  String storageButtonVal;
  String storageButtonName;

  ButtonMeta(this.buttonName, this.button, this.buttonVal,
      this.storageButtonVal, this.storageButtonName);
  void initButton(SharedPreferences prefs) {
    buttonVal = prefs.getInt(storageButtonVal) ?? 20;
    buttonName = prefs.getString(storageButtonName) ?? buttonName;
  }
}

class Controller extends StatefulWidget {
  const Controller({Key? key}) : super(key: key);
  @override
  ControllerPage createState() => ControllerPage();
}

class ControllerPage extends State<Controller> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool isConnected = false;

  final _formKey = GlobalKey<FormState>();
  double val = 20;
  final ButtonMeta buttonFirst = ButtonMeta(
      "Brak",
      CCMessage(channel: 0, controller: 64, value: 64),
      20,
      "first_value",
      "first_name");
  final ButtonMeta buttonSecond = ButtonMeta(
      "Brak",
      CCMessage(channel: 0, controller: 64, value: 64),
      20,
      "second_value",
      "second_name");
  final ButtonMeta buttonThird = ButtonMeta(
      "Brak",
      CCMessage(channel: 0, controller: 64, value: 64),
      20,
      'third_value',
      'third_name');
  final ButtonMeta buttonFourth = ButtonMeta(
      "Brak",
      CCMessage(channel: 0, controller: 64, value: 64),
      20,
      'fourth_value',
      'fourth_name');
  final ButtonMeta buttonFifth = ButtonMeta(
      "Brak",
      CCMessage(channel: 0, controller: 64, value: 64),
      20,
      'fifth_value',
      'fifth_name');
  final ButtonMeta buttonSixth = ButtonMeta(
      "Brak",
      CCMessage(channel: 0, controller: 64, value: 64),
      20,
      'sixth_value',
      'sixth_name');
  final ButtonMeta buttonSeventh = ButtonMeta(
      "Brak",
      CCMessage(channel: 0, controller: 64, value: 64),
      20,
      'seventh_value',
      'seventh_name');
  final ButtonMeta buttonEighth = ButtonMeta(
      "Brak",
      CCMessage(channel: 0, controller: 64, value: 64),
      20,
      'eighth_value',
      'eighth_name');
  final ButtonMeta buttonNineth = ButtonMeta(
      "Brak",
      CCMessage(channel: 0, controller: 64, value: 64),
      20,
      'nineth_value',
      'nineth_name');
  final ButtonMeta buttonTenth = ButtonMeta(
      "Brak",
      CCMessage(channel: 0, controller: 64, value: 64),
      20,
      'tenth_value',
      'tenth_name');
  final ButtonMeta buttonEleventh = ButtonMeta(
      "Brak",
      CCMessage(channel: 0, controller: 64, value: 64),
      20,
      'eleventh_value',
      'eleventh_name');
  final ButtonMeta buttonTwelfth = ButtonMeta(
      "1",
      CCMessage(channel: 0, controller: 69, value: 0),
      20,
      'twelfth_value',
      'twelfth_name');
  final ButtonMeta buttonThirteenth = ButtonMeta(
      "2",
      CCMessage(channel: 0, controller: 69, value: 1),
      20,
      'thirteenth_value',
      'thirteenth_name');
  final ButtonMeta buttonFourteenth = ButtonMeta(
      "3",
      CCMessage(channel: 0, controller: 69, value: 2),
      20,
      'fourteenth_value',
      'fourteenth_name');
  final ButtonMeta buttonFifteenth = ButtonMeta(
      "4",
      CCMessage(channel: 0, controller: 69, value: 3),
      20,
      'fifteenth_value',
      'fifteenth_name');
  final ButtonMeta buttonSixteenth = ButtonMeta(
      "Brak",
      CCMessage(channel: 0, controller: 64, value: 64),
      20,
      'sixteenth_value',
      'sixteenth_name');
  final ButtonMeta buttonSeventeenth = ButtonMeta(
      "Brak",
      CCMessage(channel: 0, controller: 64, value: 64),
      20,
      'seventeenth_value',
      'seventeenth_name');
  final ButtonMeta buttonEighteenth = ButtonMeta(
      "Brak",
      CCMessage(channel: 0, controller: 64, value: 64),
      20,
      'eighteenth_value',
      'eighteenth_name');
  final ButtonMeta buttonNineteenth = ButtonMeta(
      "Brak",
      CCMessage(channel: 0, controller: 64, value: 64),
      20,
      'nineteenth_value',
      'nineteenth_name');
  StreamSubscription<String>? _setupSubscription;
  final MidiCommand _midiCommand = MidiCommand();
  MidiDevice? _midiDevice;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _postInit();
    });
    _setupSubscription = _midiCommand.onMidiSetupChanged?.listen((data) async {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _setupSubscription?.cancel();
    super.dispose();
  }

  void _postInit() async {
    await _prefs.then((prefs) {
      setState(() {
        buttonFirst.initButton(prefs);
        buttonSecond.initButton(prefs);
        buttonThird.initButton(prefs);
        buttonFourth.initButton(prefs);
        buttonFifth.initButton(prefs);
        buttonSixth.initButton(prefs);
        buttonSeventh.initButton(prefs);
        buttonEighth.initButton(prefs);
        buttonNineth.initButton(prefs);
        buttonTenth.initButton(prefs);
        buttonEleventh.initButton(prefs);
        buttonTwelfth.initButton(prefs);
        buttonThirteenth.initButton(prefs);
        buttonFourteenth.initButton(prefs);
        buttonFifteenth.initButton(prefs);
        buttonSixteenth.initButton(prefs);
        buttonSeventeenth.initButton(prefs);
        buttonEighteenth.initButton(prefs);
        buttonNineteenth.initButton(prefs);
        globalFontSize = prefs.getInt("font_size") ?? 35;
        darkMode = prefs.getBool("dark_mode") ?? true;
      });
    });
  }

  ElevatedButton createSnapshotButton(ButtonMeta button) {
    return ElevatedButton(
      onLongPress: () {
        showDialog<void>(
            context: context,
            builder: (context) => StatefulBuilder(builder: (context, state) {
                  return AlertDialog(
                    content: Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        Positioned(
                          right: -40,
                          top: -40,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.red,
                              child: Icon(Icons.close),
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: TextFormField(
                                  style: TextStyle(
                                      fontSize: globalFontSize.toDouble()),
                                  decoration: InputDecoration(
                                      labelText: "Nazwa",
                                      hintText: button.buttonName),
                                  onSaved: (String? value) async {
                                    if (value != null && value.isNotEmpty) {
                                      button.buttonName = value;
                                      await _prefs.then((prefs) {
                                        prefs.setString(
                                            button.storageButtonName, value);
                                        setState(() {});
                                      });
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: ElevatedButton(
                                  child: const Text('Zatwierdź'),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      Navigator.pop(context);
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }));
      },
      onPressed: () async {
        button.button.send();
      },
      style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
      child: Text(button.buttonName,
          style: TextStyle(fontSize: globalFontSize.toDouble())),
    );
  }

  ElevatedButton createTempoButton(ButtonMeta button) {
    return ElevatedButton(
      onLongPress: () {
        showDialog<void>(
            context: context,
            builder: (context) => StatefulBuilder(builder: (context, state) {
                  return AlertDialog(
                    content: Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        Positioned(
                          right: -40,
                          top: -40,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.red,
                              child: Icon(Icons.close),
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Slider(
                                  value: button.buttonVal.toDouble(),
                                  min: 20,
                                  max: 240,
                                  divisions: 220,
                                  label: button.buttonVal.toString(),
                                  onChanged: (double value) async {
                                    await _prefs.then((prefs) {
                                      button.buttonVal = value.round();
                                      prefs.setInt(button.storageButtonVal,
                                          value.round());
                                      state(() {});
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: TextFormField(
                                  style: TextStyle(
                                      fontSize: globalFontSize.toDouble()),
                                  decoration: InputDecoration(
                                      labelText: "Wartosc tempa",
                                      hintText: button.buttonVal.toString()),
                                  keyboardType: TextInputType.number,
                                  onSaved: (String? value) async {
                                    if (value != null && value.isNotEmpty) {
                                      await _prefs.then((prefs) {
                                        button.buttonVal = int.parse(value);
                                        prefs.setInt(button.storageButtonVal,
                                            int.parse(value));
                                        setState(() {});
                                      });
                                    }
                                  },
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: TextFormField(
                                  style: TextStyle(
                                      fontSize: globalFontSize.toDouble()),
                                  decoration: InputDecoration(
                                      labelText: "Nazwa",
                                      hintText: button.buttonName),
                                  onSaved: (String? value) async {
                                    if (value != null && value.isNotEmpty) {
                                      button.buttonName = value;
                                      await _prefs.then((prefs) {
                                        prefs.setString(
                                            button.storageButtonName, value);
                                        setState(() {});
                                      });
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: ElevatedButton(
                                  child: const Text('Zatwierdź'),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      Navigator.pop(context);
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }));
      },
      onPressed: () async {
        var durationVal = 60000 / button.buttonVal;
        var duration = Duration(milliseconds: durationVal.round() - 5);
        button.button.send();
        await Future.delayed(duration);
        button.button.send();
      },
      child: Text(button.buttonName,
          style: TextStyle(fontSize: globalFontSize.toDouble())),
    );
  }

  void connectDevice(MidiDevice device) async {
    await _midiCommand.connectToDevice(device).then((_) {
      isConnected = true;
      setState(() {});
    });
  }

  void disconnectDevice(MidiDevice device) async {
    _midiCommand.disconnectDevice(device);
    isConnected = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: const Text('Midi podgo'),
        actions: [
          FutureBuilder(
              future: _midiCommand.devices,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  var devices = snapshot.data as List<MidiDevice>;
                  return Checkbox(
                      tristate: true,
                      value: devices.isEmpty ? null : isConnected,
                      onChanged: devices.isEmpty
                          ? null
                          : (bool? value) {
                              MidiDevice device = devices[0];
                              if (value == false || value == null) {
                                disconnectDevice(device);
                              } else {
                                connectDevice(device);
                              }
                            });
                } else {
                  return const Checkbox(
                      value: null, onChanged: null, tristate: true);
                }
              }),
          IconButton(
            icon: const Icon(Icons.font_download, color: Colors.white),
            onPressed: () {
              showDialog<void>(
                  context: context,
                  builder: (context) =>
                      StatefulBuilder(builder: (context, state) {
                        return AlertDialog(
                          content: Stack(
                            clipBehavior: Clip.none,
                            children: <Widget>[
                              Positioned(
                                right: -40,
                                top: -40,
                                child: InkResponse(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.red,
                                    child: Icon(Icons.close),
                                  ),
                                ),
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: TextFormField(
                                        style: TextStyle(
                                            fontSize:
                                                globalFontSize.toDouble()),
                                        decoration: InputDecoration(
                                            labelText: "Wielkość czcionki",
                                            hintText:
                                                globalFontSize.toString()),
                                        keyboardType: TextInputType.number,
                                        onSaved: (String? value) async {
                                          if (value != null &&
                                              value.isNotEmpty) {
                                            await _prefs.then((prefs) {
                                              globalFontSize = int.parse(value);
                                              prefs.setInt("font_size",
                                                  int.parse(value));
                                              setState(() {});
                                            });
                                          }
                                        },
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: ElevatedButton(
                                        child: const Text('Zatwierdź'),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _formKey.currentState!.save();
                                            Navigator.pop(context);
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }));
            },
          ),
          Switch(
            value: darkMode,
            onChanged: (newValue) async {
              await _prefs.then((prefs) {
                darkMode = newValue;
                prefs.setBool("dark_mode", newValue);
                setState(() {});
              });
            },
          )
        ],
      ),
      body: Column(children: <Widget>[
        Expanded(
            flex: 85,
            child: GridView.count(
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 2.15),
                primary: false,
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 7, bottom: 5),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                children: [
                  createTempoButton(buttonFirst),
                  createTempoButton(buttonSecond),
                  createTempoButton(buttonThird),
                  createTempoButton(buttonFourth),
                  createTempoButton(buttonFifth),
                  createTempoButton(buttonSixth),
                  createTempoButton(buttonSeventh),
                  createTempoButton(buttonEighth),
                  createTempoButton(buttonNineth),
                  createTempoButton(buttonTenth),
                  createTempoButton(buttonEleventh),
                  createTempoButton(buttonSixteenth),
                  createTempoButton(buttonSeventeenth),
                  createTempoButton(buttonEighteenth),
                  createTempoButton(buttonNineteenth),
                ])),
        Expanded(
            flex: 15,
            child: GridView.count(
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 2.1),
                primary: false,
                padding: const EdgeInsets.only(
                    bottom: 10, left: 20, right: 20, top: 10),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 4,
                children: [
                  createSnapshotButton(buttonTwelfth),
                  createSnapshotButton(buttonThirteenth),
                  createSnapshotButton(buttonFourteenth),
                  createSnapshotButton(buttonFifteenth),
                ]))
      ]),
    );
  }
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    //final List<MidiDevice>? midiDevice = await _midiCommand.devices;
    //if (midiDevice != null) {
    // isConnected = midiDevice[0].connected;
    // }

    setState(() {});
  }

  IconData _deviceIconForType(String type) {
    switch (type) {
      case "native":
        return Icons.devices;
      case "network":
        return Icons.language;
      case "BLE":
        return Icons.bluetooth;
      default:
        return Icons.device_unknown;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: darkMode ? Colors.black : Colors.white),
        home: const Controller());
  }
}
