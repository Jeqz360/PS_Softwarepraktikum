import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'generated/schedule.pb.dart';
import 'generated/schedule.pbgrpc.dart';

class SchedulePage extends StatefulWidget {
  final String deviceName;

  const SchedulePage({super.key, required this.deviceName});

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final Map<String, List<Map<String, String>>> _schedule = {
    'Montag': [],
    'Dienstag': [],
    'Mittwoch': [],
    'Donnerstag': [],
    'Freitag': [],
    'Samstag': [],
    'Sonntag': [],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wochenplan - ${widget.deviceName}'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _sendScheduleToServer,
            tooltip: 'Plan an Server senden',
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 60,
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          alignment: Alignment.center,
                          color: Colors.grey.shade300,
                          child: const Text(''),
                        ),
                        ...List.generate(24, (index) {
                          return Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: Text('${index.toString().padLeft(2, '0')}:00'),
                          );
                        }),
                      ],
                    ),
                  ),
                  ..._schedule.keys.map((day) {
                    return Column(
                      children: [
                        Container(
                          height: 50,
                          width: 120,
                          alignment: Alignment.center,
                          color: Colors.grey.shade200,
                          child: Text(
                            day,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Stack(
                          children: [
                            Column(
                              children: List.generate(24, (hour) {
                                return GestureDetector(
                                  onTap: () => _addScheduleDialog(day, hour),
                                  child: Container(
                                    height: 50,
                                    width: 120,
                                    margin: const EdgeInsets.all(0.5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey.shade300),
                                    ),
                                  ),
                                );
                              }),
                            ),
                            ..._buildOverlayBlocks(day),
                          ],
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildOverlayBlocks(String day) {
    final List<Map<String, String>>? entries = _schedule[day];
    if (entries == null || entries.isEmpty) return [];

    return entries.map((entry) {
      final startHour = int.parse(entry['start']!.split(':')[0]);
      final startMinute = int.parse(entry['start']!.split(':')[1]);
      final endHour = int.parse(entry['end']!.split(':')[0]);
      final endMinute = int.parse(entry['end']!.split(':')[1]);

      final totalMinutes = ((endHour - startHour) * 60) + (endMinute - startMinute);
      double blockHeight = (totalMinutes / 60) * 50;
      final topOffset = (startHour * 50) + (startMinute / 60) * 50;

      return Positioned(
        top: topOffset,
        left: 0,
        right: 0,
        height: blockHeight,
        child: GestureDetector(
          onLongPress: () => _showOptionsDialog(day, entry),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 1),
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    '${entry['start']} - ${entry['end']}',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

  void _showOptionsDialog(String day, Map<String, String> entry) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Termin Optionen'),
          content: const Text('Möchten Sie diesen Termin bearbeiten oder löschen?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _editScheduleDialog(day, entry);
              },
              child: const Text('Bearbeiten'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteSchedule(day, entry);
                _sendScheduleToServer(); // Nach dem Löschen senden
              },
              child: const Text('Löschen', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Abbrechen'),
            ),
          ],
        );
      },
    );
  }

  void _addScheduleDialog(String day, int hour) {
    final TextEditingController startController = TextEditingController(
        text: '${hour.toString().padLeft(2, '0')}:00');
    final TextEditingController endController = TextEditingController(
        text: '${(hour + 1).toString().padLeft(2, '0')}:00');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Zeit hinzufügen - $day'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: startController,
                decoration: const InputDecoration(labelText: 'Startzeit (HH:MM)'),
                keyboardType: TextInputType.datetime,
              ),
              TextField(
                controller: endController,
                decoration: const InputDecoration(labelText: 'Endzeit (HH:MM)'),
                keyboardType: TextInputType.datetime,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Abbrechen'),
            ),
            TextButton(
              onPressed: () {
                if (startController.text.isNotEmpty &&
                    endController.text.isNotEmpty) {
                  final start = startController.text;
                  final end = endController.text;

                  setState(() {
                    _schedule[day]?.add({'start': start, 'end': end});
                  });

                  // Sende den gesamten Wochenplan nach jeder Änderung
                  _sendScheduleToServer();
                }
                Navigator.of(context).pop();
              },
              child: const Text('Hinzufügen'),
            ),
          ],
        );
      },
    );
  }

  void _editScheduleDialog(String day, Map<String, String> entry) {
    final TextEditingController startController = TextEditingController(text: entry['start']);
    final TextEditingController endController = TextEditingController(text: entry['end']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Termin bearbeiten - $day'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: startController,
                decoration: const InputDecoration(labelText: 'Startzeit (HH:MM)'),
              ),
              TextField(
                controller: endController,
                decoration: const InputDecoration(labelText: 'Endzeit (HH:MM)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Abbrechen'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  entry['start'] = startController.text;
                  entry['end'] = endController.text;
                });

                // Sende den gesamten Wochenplan nach jeder Änderung
                _sendScheduleToServer();

                Navigator.of(context).pop();
              },
              child: const Text('Speichern'),
            ),
          ],
        );
      },
    );
  }

  void _deleteSchedule(String day, Map<String, String> entry) {
    setState(() {
      _schedule[day]?.remove(entry);
    });

    // Sende den gesamten Wochenplan nach dem Löschen
    _sendScheduleToServer();
  }

  void _sendScheduleToServer() async {
    final channel = ClientChannel(
      '10.0.2.2', // Server-Adresse
      port: 50051,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    final client = SendConditionClient(channel);

    try {
      List<Condition> conditions = [];
      _schedule.forEach((day, entries) {
        for (var entry in entries) {
          final condition = Condition()
            ..time = (Time()
              ..start = entry['start']!
              ..end = entry['end']!);
          conditions.add(condition);
        }
      });

      final aggregate = Aggregate()
        ..conditions.addAll(conditions)
        ..type = Aggregate_Type.AND;

      final condition = Condition()..type = aggregate;

      final response = await client.sendCondition(condition);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Plan erfolgreich gesendet: ${response.message}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Fehler beim Senden des Plans: $e')),
      );
    } finally {
      await channel.shutdown();
    }
  }
}
