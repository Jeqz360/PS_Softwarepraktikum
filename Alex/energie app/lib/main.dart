import 'package:flutter/material.dart';

void main() => runApp(HomeAutomationApp());

class Device {
  final String name;
  final String shortName;
  final List<Map<String, String>> rules = [];

  Device({required this.name, required this.shortName});
}

class HomeAutomationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Energie App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RuleManagementPage(),
    );
  }
}

class RuleManagementPage extends StatefulWidget {
  @override
  _RuleManagementPageState createState() => _RuleManagementPageState();
}

class _RuleManagementPageState extends State<RuleManagementPage> {
  String? ruleName;
  List<Map<String, dynamic>> selectedConditions = [
    {'type': null, 'operator': null, 'value': ''}
  ];
  List<Map<String, dynamic>> selectedActions = [
    {'device': null, 'action': null, 'value': ''}
  ];
  String? conditionConjunction = "If any conditions are met";

  List<String> conditionOptions = [
    'Außentemperatur',
    'Raumtemperatur',
    'Luftfeuchtigkeit innen',
    'Lichtintensität',
    'Bewegungssensor',
    'Fenster geöffnet',
    'Wasserstand Zisterne',
    'Stromverbrauch aktuell',
    'Stand der PV-Anlage',
    'Windgeschwindigkeit'
  ];
  List<String> devices = [
    'Heizung',
    'Rollos',
    'Lüftung',
    'Lichter',
    'Wasserpumpe',
    'Alarm'
  ];
  Map<String, List<String>> deviceActions = {
    'Heizung': ['Einschalten', 'Ausschalten', 'Temperatur einstellen'],
    'Rollos': ['Hochfahren', 'Herunterfahren'],
    'Lüftung': ['Einschalten', 'Ausschalten'],
    'Lichter': ['Einschalten', 'Ausschalten'],
    'Wasserpumpe': ['Aktivieren', 'Deaktivieren'],
    'Alarm': ['Auslösen']
  };
  List<String> comparisonOperators = ['<', '>', '=='];
  List<String> conjunctionOptions = ["If any conditions are met", "If all conditions are met"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Regel erstellen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Rule name',
                border: OutlineInputBorder(),
                errorText: ruleName == null || ruleName!.isEmpty ? 'Please enter a rule name.' : null,
              ),
              onChanged: (value) {
                setState(() {
                  ruleName = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('When a new condition is met:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: conditionConjunction,
                    items: conjunctionOptions.map((option) {
                      return DropdownMenuItem(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        conditionConjunction = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            ..._buildConditions(),
            SizedBox(height: 16.0),
            Text('Do the following:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            ..._buildActions(),

            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (ruleName != null && ruleName!.isNotEmpty && selectedConditions.isNotEmpty && selectedActions.isNotEmpty) {
                  //column: devices mit action --> drüberiterieren, entity id ist geräte, an/aus/numeric; methodenaufruf client.addRule(id eine für state und eine für numeric)  neue map machen: key heißt "condition" (das ist aggrgate condition), nächster key ist "device", da kommt id von gerät rein das gewählt wurde, key "action" da komt numerischer wert oder an/aua (state) map zu machen; regel name auch noch in die map; // für proto --> im honua_flutter im resources protodatei in unsere resources geben, befehl dafür ist im makefile

                  for (var action in selectedActions) {

                    //todo condition zusammenfassen TempInst?

                    //client.sendRule(TempInst... CONST,
                    Map<String, dynamic> regelMap = {
                      'ruleName': ruleName,
                      'Conditions': selectedConditions.map((condition) => {
                        'type': condition['type'],
                        'operator': condition['operator'],
                        'value': condition['value'],
                      }).toList(),
                      'entity': action.isNotEmpty ? action['device'] : null, // ID des Geräts
                      'action': action.isNotEmpty ? action['action'] : null, // Flag oder Aktion
                      if (action['value'].isNotEmpty)
                        'value': action['value']
                    };

                    // Aufruf der Methode zur Konsolenausgabe
                    print(regelMap);

                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Rule created: $ruleName - Conditions: ${_conditionsToString()}, Actions: ${_actionsToString()}'),
                    ),
                  );
                }
              },
              child: Text('Save Rule'),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildConditions() {
    List<Widget> conditionWidgets = [];
    for (int i = 0; i < selectedConditions.length; i++) {
      conditionWidgets.add(
        Row(
          children: [
            Expanded(
              flex: 2,
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Sensor',
                  border: OutlineInputBorder(),
                ),
                value: selectedConditions[i]['type'],
                items: conditionOptions.map((option) {
                  return DropdownMenuItem(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedConditions[i]['type'] = value;
                  });
                },
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              flex: 1,
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Operator',
                  border: OutlineInputBorder(),
                ),
                value: selectedConditions[i]['operator'],
                items: comparisonOperators.map((operator) {
                  return DropdownMenuItem(
                    value: operator,
                    child: Text(operator),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedConditions[i]['operator'] = value;
                  });
                },
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              flex: 2,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Value',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController.fromValue(
                  TextEditingValue(
                    text: selectedConditions[i]['value'],
                    selection: TextSelection.collapsed(offset: selectedConditions[i]['value'].length),
                  ),
                ),
                onChanged: (value) {
                  selectedConditions[i]['value'] = value;
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.add_circle),
              onPressed: () {
                setState(() {
                  selectedConditions.add({'type': null, 'operator': null, 'value': ''});
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: () {
                setState(() {
                  selectedConditions.removeAt(i);
                });
              },
            ),
          ],
        ),
      );
      conditionWidgets.add(SizedBox(height: 8.0));
    }
    return conditionWidgets;
  }

  List<Widget> _buildActions() {
    List<Widget> actionWidgets = [];
    for (int i = 0; i < selectedActions.length; i++) {
      actionWidgets.add(
        Row(
          children: [
            Expanded(
              flex: 2,
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Device',
                  border: OutlineInputBorder(),
                ),
                value: selectedActions[i]['device'],
                items: devices.map((device) {
                  return DropdownMenuItem(
                    value: device,
                    child: Text(device),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedActions[i]['device'] = value;
                    selectedActions[i]['action'] = null;
                    selectedActions[i]['value'] = '';
                  });
                },
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              flex: 2,
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Action',
                  border: OutlineInputBorder(),
                ),
                value: selectedActions[i]['action'],
                items: (selectedActions[i]['device'] != null ? deviceActions[selectedActions[i]['device']] ?? [] : []).map<DropdownMenuItem<String>>((action) {
                  return DropdownMenuItem(
                    value: action,
                    child: Text(action),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedActions[i]['action'] = value;
                    if (value != 'Temperatur einstellen') {
                      selectedActions[i]['value'] = '';
                    }
                  });
                },
              ),
            ),
            SizedBox(width: 8.0),
            if (selectedActions[i]['action'] == 'Temperatur einstellen')
              Expanded(
                flex: 2,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Value',
                    border: OutlineInputBorder(),
                  ),
                  controller: TextEditingController.fromValue(
                    TextEditingValue(
                      text: selectedActions[i]['value'],
                      selection: TextSelection.collapsed(offset: selectedActions[i]['value'].length),
                    ),
                  ),
                  onChanged: (value) {
                    selectedActions[i]['value'] = value;
                  },
                ),
              ),
            IconButton(
              icon: Icon(Icons.add_circle),
              onPressed: () {
                setState(() {
                  selectedActions.add({'device': null, 'action': null, 'value': ''});
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: () {
                setState(() {
                  selectedActions.removeAt(i);
                });
              },
            ),
          ],
        ),
      );
      actionWidgets.add(SizedBox(height: 8.0));
    }
    return actionWidgets;
  }

  void _addConditionDialog() {
    setState(() {
      selectedConditions.add({'type': conditionOptions[0], 'operator': comparisonOperators[0], 'value': ''});
    });
  }

  void _addActionDialog() {
    setState(() {
      selectedActions.add({'device': devices[0], 'action': deviceActions[devices[0]]![0], 'value': ''});
    });
  }

  String _conditionsToString() {
    return selectedConditions.map((condition) => '${condition['type']} ${condition['operator']} ${condition['value']}').join(' $conditionConjunction ');
  }

  String _actionsToString() {
    return selectedActions.map((action) => '${action['device']} ${action['action']} ${action['value']}').join(', ');
  }
  void printRegelMap(Map<String, dynamic> regelMap) {
    print('RegelMap: $regelMap');
  }
}
