import 'package:flutter/material.dart';
import 'dart:math';
import 'schedule_page.dart';

class DeviceOverviewPage extends StatelessWidget {
  const DeviceOverviewPage({super.key});

  String generateDeviceId() {
    return 'ID-${Random().nextInt(10000).toString().padLeft(4, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> devices = [
      {'id': generateDeviceId(), 'name': 'Heizung Wohnzimmer'},
      {'id': generateDeviceId(), 'name': 'Heizung Schlafzimmer'},
      {'id': generateDeviceId(), 'name': 'Stromzähler Keller'},
      {'id': generateDeviceId(), 'name': 'Thermostat Küche'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Geräteübersicht'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: devices.length,
        itemBuilder: (context, index) {
          final device = devices[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 4,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              title: Text(
                device['name']!,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Geräte-ID: ${device['id']}',
                style: const TextStyle(color: Colors.grey),
              ),
              trailing: const Icon(Icons.arrow_forward, color: Colors.deepPurple),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SchedulePage(deviceName: device['name']!),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
