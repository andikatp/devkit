import 'package:devkit/core/services/ping_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PingService', () {
    test('pingHost returns valid PingResult instance', () async {
      final result = await PingService.pingHost(
        host: '127.0.0.1',
        currentSent: 0,
        currentRecv: 0,
      );

      expect(result.host, equals('127.0.0.1'));
      expect(result.packetsSent, equals(1));
      expect(result.packetsReceived, greaterThanOrEqualTo(0));
      expect(result.packetLossPercent, greaterThanOrEqualTo(0.0));
    });
  });
}
