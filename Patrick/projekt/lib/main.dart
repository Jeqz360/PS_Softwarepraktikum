import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Regel System Beispiel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegelSystemPage(),
    );
  }
}

class RegelSystemPage extends StatefulWidget {
  @override
  _RegelSystemPageState createState() => _RegelSystemPageState();
}

class _RegelSystemPageState extends State<RegelSystemPage> {
  List<Map<String, dynamic>> _regeln = [];
  double _raumtemperatur = 20.0;
  String _gesteuertesElement = 'Pumpe';
  double _eingestellteTemperatur = 5.0;
  String _aktion = 'Keine Aktion erforderlich';

  void _updateAktion() {
    setState(() {
      for (var regel in _regeln) {
        if (regel['element'] == _gesteuertesElement) {
          if ((_gesteuertesElement == 'Pumpe' && _raumtemperatur < regel['temperatur']) ||
              (_gesteuertesElement == 'Fußbodenheizung' && _raumtemperatur > regel['temperatur']) ||
              (_gesteuertesElement == 'Klimaanlage' && _raumtemperatur > regel['temperatur']) ||
              (_gesteuertesElement == 'Heizung' && _raumtemperatur < regel['temperatur'])) {
            _aktion = '${regel['element']} ein';
          } else {
            _aktion = '${regel['element']} aus';
          }
        }
      }
    });
  }

  void _regelHinzufuegen() {
    setState(() {
      // Überprüfen, ob bereits eine Regel für das gesteuerte Element existiert
      var vorhandeneRegel = _regeln.indexWhere((regel) => regel['element'] == _gesteuertesElement);
      if (vorhandeneRegel == -1) {
        _regeln.add({
          'element': _gesteuertesElement,
          'temperatur': _eingestellteTemperatur,
        });
      } else {
        // Regel aktualisieren, wenn bereits eine existiert
        _regeln[vorhandeneRegel] = {
          'element': _gesteuertesElement,
          'temperatur': _eingestellteTemperatur,
        };
      }
      _updateAktion();
    });
  }

  void _regelLoeschen(int index) {
    setState(() {
      _regeln.removeAt(index);
      _updateAktion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Regel System Beispiel'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: _gesteuertesElement,
              items: <String>['Pumpe', 'Fußbodenheizung', 'Klimaanlage', 'Heizung']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _gesteuertesElement = newValue!;
                });
              },
            ),
            SizedBox(height: 30),
            Text(
              'Eingestellte Temperatur: ${_eingestellteTemperatur.toStringAsFixed(1)}°C',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Slider(
              value: _eingestellteTemperatur,
              min: -10,
              max: 40,
              divisions: 100,
              label: _eingestellteTemperatur.toStringAsFixed(1),
              onChanged: (value) {
                setState(() {
                  _eingestellteTemperatur = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _regelHinzufuegen,
              child: Text('Regel hinzufügen'),
            ),
            SizedBox(height: 30),
            Text(
              'Raumtemperatur: ${_raumtemperatur.toStringAsFixed(1)}°C',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_drop_down),
                  onPressed: () {
                    setState(() {
                      _raumtemperatur = (_raumtemperatur - 0.5).clamp(-10, 40);
                      _updateAktion();
                    });
                  },
                ),
                SizedBox(width: 20),
                Text(
                  '${_raumtemperatur.toStringAsFixed(1)}°C',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(Icons.arrow_drop_up),
                  onPressed: () {
                    setState(() {
                      _raumtemperatur = (_raumtemperatur + 0.5).clamp(-10, 40);
                      _updateAktion();
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              'Aktion: $_aktion',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: _regeln.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      tileColor: Colors.grey[200],
                      title: Text('${_regeln[index]['element']} bei ${_regeln[index]['temperatur']}°C'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _regelLoeschen(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
