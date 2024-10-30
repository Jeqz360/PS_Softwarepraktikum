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
  @override
  void initState() {
    super.initState();
    _updateConditionsAndActions();
  }

  String? ruleName;
  List<Map<String, dynamic>> selectedConditions = [];
  List<Map<String, dynamic>> selectedActions = [];
  String? conditionConjunction = "UND";

  List<String> sensors = [
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
  List<String> actions = [
    'Heizung einschalten',
    'Heizung ausschalten',
    'Lüftung einschalten',
    'Lüftung ausschalten',
    'Bodenheizung aktivieren',
    'Bodenheizung deaktivieren',
    'Rollos herunterfahren',
    'Rollos hochfahren',
    'Lichter einschalten',
    'Lichter ausschalten',
    'Wasserpumpe aktivieren',
    'Alarm auslösen'
  ];
  List<String> comparisonOperators = ['>', '<', '=='];
  List<String> conjunctionOptions = ['UND', 'ODER'];

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
                labelText: 'Ihre Regel benennen',
                border: OutlineInputBorder(),
                errorText: ruleName == null || ruleName!.isEmpty ? 'Einen Namen eingeben.' : null,
              ),
              onChanged: (value) {
                setState(() {
                  ruleName = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            Text('Bedingungen hinzufügen:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            ..._buildConditions(),
            TextButton(
              onPressed: () {
                _addConditionDialog();
              },
              child: Text('Eine weitere Bedingung hinzufügen'),
            ),
            SizedBox(height: 16.0),
            Text('Aktionen hinzufügen:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            ..._buildActions(),
            TextButton(
              onPressed: () {
                _addActionDialog();
              },
              child: Text('Weitere Aktion hinzufügen'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (ruleName != null && ruleName!.isNotEmpty && selectedConditions.isNotEmpty && selectedActions.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Regel erstellt: $ruleName - Bedingungen: ${_conditionsToString()}, Aktionen: ${_actionsToString()}'),
                    ),
                  );
                }
              },
              child: Text('Regel speichern'),
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
              child: Text(
                '${selectedConditions[i]['sensor']} ${selectedConditions[i]['operator']} ${selectedConditions[i]['value']}',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                setState(() {
                  selectedConditions.removeAt(i);
                });
              },
            ),
          ],
        ),
      );
      if (i < selectedConditions.length - 1) {
        conditionWidgets.add(
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Verknüpfung der Bedingungen auswählen',
              border: OutlineInputBorder(),
            ),
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
        );
      }
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
              child: Text(
                '${selectedActions[i]['action']}',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                setState(() {
                  selectedActions.removeAt(i);
                });
              },
            ),
          ],
        ),
      );
    }
    return actionWidgets;
  }

  void _updateConditionsAndActions() {
    setState(() {});
  }

  void _addConditionDialog() {
    String? selectedSensor;
    String? selectedOperator;
    String? conditionValue;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bedingung hinzufügen'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Sensor auswählen',
                  border: OutlineInputBorder(),
                ),
                items: sensors.map((sensor) {
                  return DropdownMenuItem(
                    value: sensor,
                    child: Text(sensor),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedSensor = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Operator auswählen',
                  border: OutlineInputBorder(),
                ),
                items: comparisonOperators.map((operator) {
                  return DropdownMenuItem(
                    value: operator,
                    child: Text(operator),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedOperator = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Wert eingeben (z.B. 25°C)',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  conditionValue = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Abbrechen'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Hinzufügen'),
              onPressed: () {
                if (selectedSensor != null && selectedOperator != null && conditionValue != null && conditionValue!.isNotEmpty) {
                  setState(() {
                    selectedConditions.add({'sensor': selectedSensor!, 'operator': selectedOperator!, 'value': conditionValue!});
                  });
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _addActionDialog() {
    String? selectedAction;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Aktion hinzufügen'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Aktion auswählen',
                  border: OutlineInputBorder(),
                ),
                items: actions.map((action) {
                  return DropdownMenuItem(
                    value: action,
                    child: Text(action),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedAction = value;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Abbrechen'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Hinzufügen'),
              onPressed: () {
                if (selectedAction != null) {
                  setState(() {
                    selectedActions.add({'action': selectedAction!});
                  });
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String _conditionsToString() {
    return selectedConditions.map((condition) => '${condition['sensor']} ${condition['operator']} ${condition['value']}').join(' $conditionConjunction ');
  }

  String _actionsToString() {
    return selectedActions.map((action) => action['action']).join(', ');
  }
}
