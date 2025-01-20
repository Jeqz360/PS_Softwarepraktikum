import 'package:flutter/material.dart';
import 'device_overview_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Scheduler',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DeviceOverviewPage(),
    );
  }
}
