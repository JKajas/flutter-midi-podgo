import 'dart:async';

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
  CCMessage button;
  String storageButtonVal;
  String storageButtonName;

  ButtonMeta(this.buttonName, this.button, this.storageButtonVal,
      this.storageButtonName);
  void initButton(SharedPreferences prefs) {
    button.value = prefs.getInt(storageButtonVal) ?? 0;
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
      "No name",
      CCMessage(channel: 0, controller: 64, value: 0),
      "first_value",
      "first_name");
  final ButtonMeta buttonSecond = ButtonMeta(
      "No name",
      CCMessage(channel: 0, controller: 64, value: 0),
      "second_value",
      "second_name");
  final ButtonMeta buttonThird = ButtonMeta(
      "No name",
      CCMessage(channel: 0, controller: 64, value: 0),
      'third_value',
      'third_name');
  final ButtonMeta buttonFourth = ButtonMeta(
      "No name",
      CCMessage(channel: 0, controller: 64, value: 0),
      'fourth_value',
      'fourth_name');
  final ButtonMeta buttonFifth = ButtonMeta(
      "No name",
      CCMessage(channel: 0, controller: 64, value: 0),
      'fifth_value',
      'fifth_name');
  final ButtonMeta buttonSixth = ButtonMeta(
      "No name",
      CCMessage(channel: 0, controller: 64, value: 0),
      'sixth_value',
      'sixth_name');
  final ButtonMeta buttonSeventh = ButtonMeta(
      "No name",
      CCMessage(channel: 0, controller: 64, value: 0),
      'seventh_value',
      'seventh_name');
  final ButtonMeta buttonEighth = ButtonMeta(
      "No name",
      CCMessage(channel: 0, controller: 64, value: 0),
      'eighth_value',
      'eighth_name');
  final ButtonMeta buttonNineth = ButtonMeta(
      "No name",
      CCMessage(channel: 0, controller: 64, value: 0),
      'nineth_value',
      'nineth_name');

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
    });
  }

  ElevatedButton createTempoButton(ButtonMeta button) {
    return ElevatedButton(
      onLongPress: () {
        showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
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
                      Slider(
                        value: val,
                        min: 0,
                        max: 127,
                        divisions: 127,
                        label: val.toString(),
                        onChanged: (double value) {
                          setState(() async {
                            val = value;
                          });
                        },
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    labelText: "Enter your number"),
                                keyboardType: TextInputType.number,
                                onSaved: (String? value) {
                                  if (value != null) {
                                    setState(() async {
                                      button.button.value = int.parse(value);
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
                              child: TextFormField(onSaved: (String? value) {
                                if (value != null) {
                                  setState(() async {
                                    button.buttonName = value;
                                    final SharedPreferences prefs =
                                        await _prefs;
                                    prefs.setString(
                                        button.storageButtonName, value);
                                  });
                                }
                              }),
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
                ));
      },
      onPressed: () {
        button.button.send();
      },
      child: Text(button.buttonName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zapisane'),
      ),
      body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
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
          ]),
    );
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
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MidiUsb'),
          actions: <Widget>[
            Switch(
                value: true,
                onChanged: (newValue) {
                  setState(() {});
                }),
            Switch(
                value: true,
                onChanged: (newValue) {
                  setState(() {});
                }),
            Builder(builder: (context) {
              return IconButton(
                  onPressed: () {}, icon: const Icon(Icons.refresh));
            }),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(24.0),
          child: const Text(
            "Tap to connnect/disconnect, long press to control.",
            textAlign: TextAlign.center,
          ),
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
                      title: Text(
                        device.name,
                        style: Theme.of(context).textTheme.headlineSmall,
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
                            CCMessage(channel: 0, controller: 7, value: 127)
                                .send();
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
