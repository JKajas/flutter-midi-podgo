import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_midi_command/flutter_midi_command_messages.dart';

void main() => runApp(const MyApp());

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
    buttonVal = prefs.getInt(storageButtonVal) ?? 0;
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
  final _formKey = GlobalKey<FormState>();
  double val = 0;
  final ButtonMeta buttonFirst = ButtonMeta(
      "Brak",
      CCMessage(channel: 0, controller: 64, value: 64),
      0,
      "first_value",
      "first_name");
  final ButtonMeta buttonSecond = ButtonMeta(
      "Brak",
      CCMessage(channel: 0, controller: 64, value: 64),
      0,
      "second_value",
      "second_name");
  final ButtonMeta buttonThird = ButtonMeta(
      "Brak",
      CCMessage(channel: 0, controller: 64, value: 64),
      0,
      'third_value',
      'third_name');
  final ButtonMeta buttonFourth = ButtonMeta(
      "Brak",
      CCMessage(channel: 0, controller: 64, value: 64),
      0,
      'fourth_value',
      'fourth_name');
  final ButtonMeta buttonFifth = ButtonMeta(
      "Brak",
      CCMessage(channel: 0, controller: 64, value: 64),
      0,
      'fifth_value',
      'fifth_name');
  final ButtonMeta buttonSixth = ButtonMeta(
      "Brak",
      CCMessage(channel: 0, controller: 64, value: 64),
      0,
      'sixth_value',
      'sixth_name');
  final ButtonMeta buttonSeventh = ButtonMeta(
      "Brak",
      CCMessage(channel: 0, controller: 64, value: 64),
      0,
      'seventh_value',
      'seventh_name');
  final ButtonMeta buttonEighth = ButtonMeta(
      "Brak",
      CCMessage(channel: 0, controller: 64, value: 64),
      0,
      'eighth_value',
      'eighth_name');
  final ButtonMeta buttonNineth = ButtonMeta(
      "Brak",
      CCMessage(channel: 0, controller: 64, value: 64),
      0,
      'nineth_value',
      'nineth_name');
  final ButtonMeta buttonTenth = ButtonMeta(
      "Brak",
      CCMessage(channel: 0, controller: 64, value: 64),
      0,
      'tenth_value',
      'tenth_name');
  final ButtonMeta buttonEleventh = ButtonMeta(
      "Brak",
      CCMessage(channel: 0, controller: 64, value: 64),
      0,
      'eleventh_value',
      'eleventh_name');
  final ButtonMeta buttonTwelfth = ButtonMeta(
      "1",
      CCMessage(channel: 0, controller: 69, value: 0),
      0,
      'twelfth_value',
      'twelfth_name');
  final ButtonMeta buttonThirteenth = ButtonMeta(
      "2",
      CCMessage(channel: 0, controller: 69, value: 1),
      0,
      'thirteenth_value',
      'thirteenth_name');
  final ButtonMeta buttonFourteenth = ButtonMeta(
      "3",
      CCMessage(channel: 0, controller: 69, value: 2),
      0,
      'fourteenth_value',
      'fourteenth_name');
  final ButtonMeta buttonFifteenth = ButtonMeta(
      "4",
      CCMessage(channel: 0, controller: 69, value: 3),
      0,
      'fifteenth_value',
      'fifteenth_name');
  final ButtonMeta buttonSixteenth = ButtonMeta(
      "Brak",
      CCMessage(channel: 0, controller: 64, value: 64),
      0,
      'sixteenth_value',
      'sixteenth_name');
  final ButtonMeta buttonSeventeenth = ButtonMeta(
      "Brak",
      CCMessage(channel: 0, controller: 64, value: 64),
      0,
      'seventeenth_value',
      'seventeenth_name');
  final ButtonMeta buttonEighteenth = ButtonMeta(
      "Brak",
      CCMessage(channel: 0, controller: 64, value: 64),
      0,
      'eighteenth_value',
      'eighteenth_name');
  final ButtonMeta buttonNineteenth = ButtonMeta(
      "Brak",
      CCMessage(channel: 0, controller: 64, value: 64),
      0,
      'nineteenth_value',
      'nineteenth_name');

  @override
  void initState() async {
    super.initState();
    final SharedPreferences prefs = await _prefs;
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
                                  style: const TextStyle(fontSize: 35),
                                  decoration: InputDecoration(
                                      labelText: "Nazwa",
                                      hintText: button.buttonName),
                                  onSaved: (String? value) {
                                    if (value != null && value.isNotEmpty) {
                                      button.buttonName = value;
                                      setState(() async {
                                        final SharedPreferences prefs =
                                            await _prefs;
                                        prefs.setString(
                                            button.storageButtonName, value);
                                      });
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: ElevatedButton(
                                  child: const Text('Submit'),
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
      onPressed: () {
        button.button.send();
      },
      style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
      child: Text(button.buttonName, style: const TextStyle(fontSize: 35)),
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
                                  onChanged: (double value) {
                                    state(() async {
                                      button.buttonVal = value.round();
                                      final SharedPreferences prefs =
                                          await _prefs;
                                      prefs.setInt(button.storageButtonVal,
                                          value.round());
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: TextFormField(
                                  style: const TextStyle(fontSize: 35),
                                  decoration: InputDecoration(
                                      labelText: "Wartosc tempa",
                                      hintText: button.buttonVal.toString()),
                                  keyboardType: TextInputType.number,
                                  onSaved: (String? value) {
                                    if (value != null && value.isNotEmpty) {
                                      setState(() async {
                                        button.buttonVal = int.parse(value);
                                        final SharedPreferences prefs =
                                            await _prefs;
                                        prefs.setInt(button.storageButtonVal,
                                            int.parse(value));
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
                                  style: const TextStyle(fontSize: 35),
                                  decoration: InputDecoration(
                                      labelText: "Nazwa",
                                      hintText: button.buttonName),
                                  onSaved: (String? value) {
                                    if (value != null && value.isNotEmpty) {
                                      button.buttonName = value;
                                      setState(() async {
                                        final SharedPreferences prefs =
                                            await _prefs;
                                        prefs.setString(
                                            button.storageButtonName, value);
                                      });
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: ElevatedButton(
                                  child: const Text('Submit'),
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
      onPressed: () {
        var durationVal = 60000 / button.buttonVal;
        var duration = Duration(milliseconds: durationVal.round() - 5);
        button.button.send();
        sleep(duration);
        button.button.send();
      },
      child: Text(button.buttonName, style: const TextStyle(fontSize: 35)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Zapisane'),
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            GridView.count(
                primary: false,
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 5),
                shrinkWrap: true,
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
                ]),
            GridView.count(
                primary: false,
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                shrinkWrap: true,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 4,
                children: [
                  createSnapshotButton(buttonTwelfth),
                  createSnapshotButton(buttonThirteenth),
                  createSnapshotButton(buttonFourteenth),
                  createSnapshotButton(buttonFifteenth),
                ])
          ]),
        ));
  }
}

class MyAppState extends State<MyApp> {
  StreamSubscription<String>? _setupSubscription;
  final MidiCommand _midiCommand = MidiCommand();

  @override
  void initState() {
    super.initState();

    _setupSubscription = _midiCommand.onMidiSetupChanged?.listen((data) async {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _setupSubscription?.cancel();
    super.dispose();
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
      theme: ThemeData(scaffoldBackgroundColor: Colors.black),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MidiUsb'),
        ),
        body: Center(
          child: FutureBuilder(
            future: _midiCommand.devices,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                var devices = snapshot.data as List<MidiDevice>;
                return ListView.builder(
                  itemCount: devices.length,
                  itemBuilder: (context, index) {
                    MidiDevice device = devices[index];

                    return ListTile(
                      iconColor: Colors.white,
                      title: Text(
                        device.name,
                        style: Theme.of(context)
                            .textTheme
                            .apply(bodyColor: Colors.white)
                            .headlineSmall,
                      ),
                      subtitle: Text(
                          "ins:${device.inputPorts.length} outs:${device.outputPorts.length}, ${device.id}, ${device.type}"),
                      leading: Icon(device.connected
                          ? Icons.radio_button_on
                          : Icons.radio_button_off),
                      trailing: Icon(_deviceIconForType(device.type)),
                      onTap: () {
                        if (device.connected) {
                          _midiCommand.disconnectDevice(device);
                        } else {
                          _midiCommand.connectToDevice(device).then((_) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Controller()),
                            );
                          }).catchError((err) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Error: ${(err as PlatformException?)?.message}")));
                          });
                        }
                      },
                    );
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
