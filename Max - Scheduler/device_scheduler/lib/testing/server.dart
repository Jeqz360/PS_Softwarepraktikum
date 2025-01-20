import 'dart:async';
import 'package:grpc/grpc.dart';
import '../generated/schedule.pbgrpc.dart'; // Pfad zu Ihrer generierten Datei

class SendConditionService extends SendConditionServiceBase {
  @override
  Future<Confirmation> sendCondition(ServiceCall call, Condition request) async {
    // Log die empfangene Nachricht
    print('Bedingung erhalten: ${request.toDebugString()}');

    // Beispiel: Verarbeitung der Bedingung
    if (request.hasTime()) {
      print('Zeitplan: ${request.time.start} bis ${request.time.end}');
    } else if (request.hasDay()) {
      print('Cron: ${request.day.cron}');
    } else if (request.hasType()) {
      print('Aggregat-Typ: ${request.type}');
    }

    // Antwort zurückgeben
    return Confirmation()..message = 'Bedingung erfolgreich empfangen!';
  }
}

Future<void> main() async {
  final server = Server(
    [SendConditionService()],
    const <Interceptor>[],
    CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
  );

  await server.serve(port: 50051);
  print('gRPC-Server läuft auf Port ${server.port}');
}
