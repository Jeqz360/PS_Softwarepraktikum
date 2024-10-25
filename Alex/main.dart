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
      home: DeviceSelectionPage(),
    );
  }
}

class DeviceSelectionPage extends StatelessWidget {
  final List<Device> devices = [
    Device(name: 'Heizung', shortName: 'Hz'),
    Device(name: 'Rasenmäher', shortName: 'RaMä'),
    Device(name: 'Bodenheizung', shortName: 'BoHz'),
    Device(name: 'Fensterrollo', shortName: 'FeRo'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Energie App'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AllRulesPage(devices: devices),
                ),
              );
            },
            child: Text('Alle Regeln'),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 2 / 1,
              ),
              itemCount: devices.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RuleSelectionPage(device: devices[index]),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          devices[index].shortName,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          devices[index].name,
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8.0),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RuleListPage(device: devices[index]),
                              ),
                            );
                          },
                          child: Text('Regeln anzeigen'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RuleSelectionPage extends StatefulWidget {
  final Device device;

  RuleSelectionPage({required this.device});

  @override
  _RuleSelectionPageState createState() => _RuleSelectionPageState();
}

class _RuleSelectionPageState extends State<RuleSelectionPage> {
  String? selectedCondition;
  String? selectedAction;

  List<String> conditions = [];
  List<String> actions = [];

  @override
  void initState() {
    super.initState();
    switch (widget.device.name) {
      case 'Heizung':
        conditions = ['Temperatur < 20°C', 'Temperatur > 25°C', 'Raum unbelegt', 'Feuchtigkeit < 30%'];
        actions = ['Heizung einschalten', 'Heizung ausschalten', 'Lüftung einschalten', 'Temperatur auf Zielwert setzen'];
        break;
      case 'Rasenmäher':
        conditions = ['Grashöhe > 5cm', 'Sonnig', 'Regenfrei', 'Wochentag ist Samstag'];
        actions = ['Rasenmähen starten', 'Rasenmähen stoppen', 'Mähroboter zum Laden schicken', 'Rasenmähen für eine Stunde unterbrechen'];
        break;
      case 'Bodenheizung':
        conditions = ['Temperatur < 18°C', 'Temperatur > 23°C', 'Fenster geöffnet', 'Niedrige Außentemperatur'];
        actions = ['Bodenheizung einschalten', 'Bodenheizung ausschalten', 'Bodenheizung auf Eco-Modus setzen', 'Bodenheizung auf Zieltemperatur regeln'];
        break;
      case 'Fensterrollo':
        conditions = ['Sonneneinstrahlung hoch', 'Nachtzeit', 'Windstärke > 30 km/h', 'Temperatur im Raum > 25°C'];
        actions = ['Rollo herunterfahren', 'Rollo hochfahren', 'Rollo teilweise schließen', 'Rollo öffnen, um Luftzirkulation zu ermöglichen'];
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.device.name} - Regel erstellen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('B e d i n g u n g', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                        ...conditions.map((condition) => RadioListTile(
                          title: Text(condition),
                          value: condition,
                          groupValue: selectedCondition,
                          onChanged: (String? value) {
                            setState(() {
                              selectedCondition = value;
                            });
                          },
                        )),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('A k t i o n', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                        ...actions.map((action) => RadioListTile(
                          title: Text(action),
                          value: action,
                          groupValue: selectedAction,
                          onChanged: (String? value) {
                            setState(() {
                              selectedAction = value;
                            });
                          },
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (selectedCondition != null && selectedAction != null) {
                  setState(() {
                    if (!widget.device.rules.any((rule) => rule['condition'] == selectedCondition && rule['action'] == selectedAction)) {
                      widget.device.rules.add({'condition': selectedCondition!, 'action': selectedAction!});
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Regel erstellt: Wenn $selectedCondition, dann $selectedAction'),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Regel bereits erstellt!'),
                        ),
                      );
                    }
                  });
                }
              },
              child: Text('Regel erstellen'),
            ),
          ],
        ),
      ),
    );
  }
}

class AllRulesPage extends StatelessWidget {
  final List<Device> devices;

  AllRulesPage({required this.devices});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> allRules = [];
    for (var device in devices) {
      for (var rule in device.rules) {
        allRules.add({'device': device.name, 'condition': rule['condition']!, 'action': rule['action']!});
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Alle Regeln'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: allRules.isEmpty
            ? Center(
          child: Text('Keine Regeln erstellt'),
        )
            : ListView.builder(
          itemCount: allRules.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Gerät: ${allRules[index]['device']}'),
              subtitle: Text('Bedingung: ${allRules[index]['condition']}, Aktion: ${allRules[index]['action']}'),
            );
          },
        ),
      ),
    );
  }
}

class RuleListPage extends StatelessWidget {
  final Device device;

  RuleListPage({required this.device});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${device.name} - Regeln anzeigen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: device.rules.isEmpty
            ? Center(
          child: Text('Keine Regeln erstellt'),
        )
            : ListView.builder(
          itemCount: device.rules.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Bedingung: ${device.rules[index]['condition']}'),
              subtitle: Text('Aktion: ${device.rules[index]['action']}'),
            );
          },
        ),
      ),
    );
  }
}
