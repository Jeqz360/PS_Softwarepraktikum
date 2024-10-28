import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weekly Schedule',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeeklyCalendarScreen(),
    );
  }
}

class WeeklyCalendarScreen extends StatefulWidget {
  @override
  _WeeklyCalendarScreenState createState() => _WeeklyCalendarScreenState();
}

class _WeeklyCalendarScreenState extends State<WeeklyCalendarScreen> {
  final List<String> weekdays = ["Mo", "Di", "Mi", "Do", "Fr", "Sa", "So"];
  final List<String> times = List.generate(24, (index) => "${index}:00"); // 0-24 Stunden
  final List<Color> colors = [ // Farben für überschneidende Termine
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.purple,
  ];

  // Dummyfunktionen zur Auswahl
  final List<String> dummyFunctions = ["Funktion 1", "Funktion 2", "Funktion 3"];

  // Map zum Speichern der Termine mit Listen für überlappende Einträge
  Map<String, Map<int, List<Map<String, dynamic>>>> schedules = {};

  @override
  void initState() {
    super.initState();
    // Initialisiere das Schedule-Map für jeden Wochentag
    weekdays.forEach((day) {
      schedules[day] = {};
    });
  }

  void _showActionDialog(String day, int startTimeIndex, {Map<String, dynamic>? existingEvent}) {
    TextEditingController _controller = TextEditingController(text: existingEvent?['title'] ?? '');
    int endTimeIndex = existingEvent?['endTime'] ?? startTimeIndex;
    String selectedFunction = existingEvent?['function'] ?? dummyFunctions.first;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return AlertDialog(
              title: Text(existingEvent == null
                  ? "Neuer Termin für $day um ${times[startTimeIndex]}"
                  : "Termin bearbeiten"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: "Termin eingeben"),
                  ),
                  SizedBox(height: 10),
                  // Dropdown für Dummyfunktionen
                  DropdownButton<String>(
                    value: selectedFunction,
                    items: dummyFunctions.map((function) {
                      return DropdownMenuItem<String>(
                        value: function,
                        child: Text(function),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setDialogState(() {
                        selectedFunction = newValue!;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  Text("Endzeit: ${times[endTimeIndex]}"),
                  Slider(
                    min: startTimeIndex.toDouble(),
                    max: 23,
                    value: endTimeIndex.toDouble(),
                    divisions: 23 - startTimeIndex,
                    label: times[endTimeIndex],
                    onChanged: (value) {
                      setDialogState(() {
                        endTimeIndex = value.toInt();
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text("Abbrechen"),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      if (_controller.text.isNotEmpty) {
                        // Entfernen alter Daten, falls Event existiert (Bearbeitung)
                        if (existingEvent != null) {
                          for (int i = existingEvent['startTime'];
                          i <= existingEvent['endTime'];
                          i++) {
                            schedules[day]![i]?.remove(existingEvent);
                          }
                        }
                        // Hinzufügen neuer Daten
                        for (int i = startTimeIndex; i <= endTimeIndex; i++) {
                          schedules[day]![i] ??= [];
                          schedules[day]![i]!.add({
                            "title": _controller.text,
                            "isContinued": i > startTimeIndex,
                            "startTime": startTimeIndex,
                            "endTime": endTimeIndex,
                            "function": selectedFunction,
                          });
                        }
                      }
                    });
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text("Speichern"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weekly Schedule")),
      body: Column(
        children: [
          // Header mit den Wochentagen
          Row(
            children: [
              Container(width: 60), // Platzhalter für Zeitenspalte
              ...weekdays.map((day) => Expanded(child: Center(child: Text(day)))).toList(),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: times.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    // Zeitenspalte
                    Container(
                      width: 60,
                      height: 60,
                      alignment: Alignment.center,
                      child: Text(times[index]),
                    ),
                    // Zeitslots für jeden Tag der Woche
                    ...weekdays.map((day) {
                      List<Map<String, dynamic>>? slotSchedules = schedules[day]![index];
                      int scheduleCount = slotSchedules?.length ?? 0;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => _showActionDialog(day, index),
                          child: Container(
                            height: 60,
                            margin: EdgeInsets.all(1),
                            child: scheduleCount > 0
                                ? Row(
                              children: slotSchedules!.asMap().entries.map((entry) {
                                int scheduleIndex = entry.key;
                                Map<String, dynamic> schedule = entry.value;
                                double widthFactor = 1 / scheduleCount;
                                Color color = colors[scheduleIndex % colors.length];
                                return Expanded(
                                  flex: (widthFactor * 100).toInt(),
                                  child: GestureDetector(
                                    onLongPress: () => _showActionDialog(
                                      day,
                                      schedule["startTime"],
                                      existingEvent: schedule,
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.all(1),
                                      color: schedule["isContinued"]
                                          ? color.withOpacity(0.3)
                                          : color.withOpacity(0.5),
                                      child: Center(
                                        child: schedule["isContinued"]
                                            ? Text("")
                                            : Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              schedule["title"],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  overflow: TextOverflow.ellipsis),
                                            ),
                                            Text(
                                              schedule["function"],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8,
                                                  overflow: TextOverflow.ellipsis),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            )
                                : Container(
                              color: Colors.grey.withOpacity(0.1),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
