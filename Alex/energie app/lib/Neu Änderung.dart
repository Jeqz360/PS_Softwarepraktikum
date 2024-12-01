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
  final int recursionLevel;

  RuleManagementPage({this.recursionLevel = 0});

  @override
  _RuleManagementPageState createState() => _RuleManagementPageState();
}

class _RuleManagementPageState extends State<RuleManagementPage> {
  List<Map<String, dynamic>> selectedConditions = [
    {'type': null, 'operator': null, 'value': ''}
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
  List<String> comparisonOperators = ['<', '>', '=='];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Regel erstellen - Ebene ${widget.recursionLevel + 1}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('When a new condition is met:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            ..._buildConditions(),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (selectedConditions.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Regel gespeichert: Bedingungen: ${_conditionsToString()}'),
                    ),
                  );
                  if (widget.recursionLevel == 0) {
                    // Do not pop the page if it's the first level
                  } else {
                    Navigator.of(context).pop();
                  }
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
        Column(
          children: [
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
                    _showRecursionDialog();
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
            if (selectedConditions[i]['type'] != null && selectedConditions[i]['operator'] != null && selectedConditions[i]['value'] != '')
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 4.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.link, size: 16, color: Colors.grey),
                        SizedBox(width: 4.0),
                        GestureDetector(
                          onTap: () {
                            _showRecursionDialog();
                          },
                          child: Text('Rekursive Bedingung', style: TextStyle(fontSize: 12, color: Colors.blue, decoration: TextDecoration.underline)),
                        ),
                      ],
                    ),
                    Divider(),
                  ],
                ),
              ),
            SizedBox(height: 8.0),
          ],
        ),
      );
    }
    return conditionWidgets;
  }

  void _showRecursionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String? selectedLogic = 'and';
        return AlertDialog(
          title: Text('Rekursionsoptionen'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Logic',
                  border: OutlineInputBorder(),
                ),
                value: selectedLogic,
                items: [
                  DropdownMenuItem(value: 'and', child: Text('And')),
                  DropdownMenuItem(value: 'or', child: Text('Or')),
                  DropdownMenuItem(value: 'time', child: Text('Time')),
                ],
                onChanged: (value) {
                  selectedLogic = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RuleManagementPage(recursionLevel: widget.recursionLevel + 1),
                  ),
                ).then((_) {
                  setState(() {
                    // Refresh state when returning from recursion
                  });
                });
              },
              child: Text('Proceed'),
            ),
          ],
        );
      },
    );
  }

  String _conditionsToString() {
    return selectedConditions.map((condition) => '${condition['type']} ${condition['operator']} ${condition['value']}').join(' ');
  }
}
