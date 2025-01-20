import 'package:grpc/grpc.dart';
import '../generated/schedule.pbgrpc.dart'; // Pfad zu Ihrer generierten Datei

Future<void> main() async {
  // Verbindung mit dem Server herstellen
  final channel = ClientChannel(
    'localhost', // Server-Adresse
    port: 50051,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );

  final client = SendConditionClient(channel);

  try {
    // Beispielbedingung erstellen
    final condition = Condition()
      ..time = (Time()
        ..start = "08:00"
        ..end = "10:00");

    // RPC-Aufruf senden
    final response = await client.sendCondition(condition);
    print('Server-Antwort: ${response.message}');
  } catch (e) {
    print('Fehler: $e');
  } finally {
    await channel.shutdown();
  }
}
