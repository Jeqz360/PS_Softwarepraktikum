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

  // Map zum Speichern der Termine
  Map<String, Map<int, String>> schedules = {};

  @override
  void initState() {
    super.initState();
    // Initialisiere das Schedule-Map für jeden Wochentag
    weekdays.forEach((day) {
      schedules[day] = {};
    });
  }

  void _showActionDialog(String day, int timeIndex) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController _controller = TextEditingController();
        return AlertDialog(
          title: Text("Neuer Termin für $day um ${times[timeIndex]}"),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: "Termin eingeben"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Abbrechen"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // Speichern des Termins
                  if (_controller.text.isNotEmpty) {
                    schedules[day]![timeIndex] = _controller.text;
                  }
                });
                Navigator.of(context).pop();
              },
              child: Text("Speichern"),
            ),
          ],
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
                      bool hasSchedule = schedules[day]!.containsKey(index);
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => _showActionDialog(day, index),
                          child: Container(
                            height: 60,
                            margin: EdgeInsets.all(1),
                            color: hasSchedule
                                ? Colors.blue.withOpacity(0.5) // Farbmarkierung für gebuchte Termine
                                : Colors.grey.withOpacity(0.1), // Leere Felder
                            child: Center(
                              child: hasSchedule
                                  ? Text(
                                schedules[day]![index]!,
                                style: TextStyle(color: Colors.white),
                              )
                                  : Text(""),
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
