import 'dart:io';

class PingResult {
  const new({
    required this.host,
    required this.rttMs,
    required this.packetsSent,
    required this.packetsReceived,
    required this.packetLossPercent,
    required this.isSuccess,
  });

  final String host;
  final double rttMs;
  final int packetsSent;
  final int packetsReceived;
  final double packetLossPercent;
  final bool isSuccess;

  static const PingResult initial = PingResult(
    host: '8.8.8.8',
    rttMs: 0,
    packetsSent: 0,
    packetsReceived: 0,
    packetLossPercent: 0,
    isSuccess: false,
  );
}

abstract final class PingService {
  static Future<PingResult> pingHost({
    required String host,
    required int currentSent,
    required int currentRecv,
  }) async {
    final sent = currentSent + 1;
    final cleanHost = host.contains(' ') ? host.split(' ').first : host;

    try {
      final res = await Process.run('ping', ['-c', '1', '-w', '2', cleanHost]);
      if (res.exitCode == 0) {
        final output = res.stdout.toString();
        final rtt = _parseRttMs(output);
        final recv = currentRecv + 1;
        final loss = ((sent - recv) / sent) * 100;
        return PingResult(
          host: cleanHost,
          rttMs: rtt,
          packetsSent: sent,
          packetsReceived: recv,
          packetLossPercent: loss < 0 ? 0 : loss,
          isSuccess: true,
        );
      }
    } on Exception catch (_) {
      // Fallback to TCP Socket lookup
    }

    try {
      final stopwatch = Stopwatch()..start();
      final socket = await Socket.connect(
        cleanHost,
        53,
        timeout: const Duration(milliseconds: 2000),
      );
      stopwatch.stop();
      await socket.close();

      final recv = currentRecv + 1;
      final loss = ((sent - recv) / sent) * 100;
      return PingResult(
        host: cleanHost,
        rttMs: stopwatch.elapsedMilliseconds.toDouble(),
        packetsSent: sent,
        packetsReceived: recv,
        packetLossPercent: loss < 0 ? 0 : loss,
        isSuccess: true,
      );
    } on Exception catch (_) {
      final loss = ((sent - currentRecv) / sent) * 100;
      return PingResult(
        host: cleanHost,
        rttMs: 0,
        packetsSent: sent,
        packetsReceived: currentRecv,
        packetLossPercent: loss,
        isSuccess: false,
      );
    }
  }

  static double _parseRttMs(String output) {
    try {
      final match = RegExp(r'time=([\d.]+)\s*ms').firstMatch(output);
      if (match != null) {
        return double.tryParse(match.group(1) ?? '') ?? 0;
      }
      final rttLineMatch =
          RegExp(r'= ([\d.]+)/([\d.]+)/([\d.]+)').firstMatch(output);
      if (rttLineMatch != null) {
        return double.tryParse(rttLineMatch.group(2) ?? '') ?? 0;
      }
    } on Exception catch (_) {}
    return 0;
  }
}
