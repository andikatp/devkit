import 'package:devkit/core/services/logcat_service.dart';
import 'package:devkit/features/logcat/domain/entities/logcat_log_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LogcatService', () {
    test('parseLogLine parses threadtime log lines correctly', () {
      const threadtimeLine =
          '09-09 09:50:11.412  1892  1920 I DevKitCore: '
          '[mDNS] Service resolved: _adb-tls-connect._tcp port=42715';

      final entity = LogcatService.parseLogLine(threadtimeLine);

      expect(entity.timestamp, equals('09-09 09:50:11.412'));
      expect(entity.pid, equals(1892));
      expect(entity.tid, equals(1920));
      expect(entity.level, equals(LogLevel.info));
      expect(entity.tag, equals('DevKitCore'));
      expect(
        entity.message,
        equals('[mDNS] Service resolved: _adb-tls-connect._tcp port=42715'),
      );
    });

    test('parseLogLine parses brief log lines correctly', () {
      const briefLine =
          'D/DevKitEngine( 1892): ADB Direct Mode active via granted daemon';

      final entity = LogcatService.parseLogLine(briefLine);

      expect(entity.pid, equals(1892));
      expect(entity.level, equals(LogLevel.debug));
      expect(entity.tag, equals('DevKitEngine'));
      expect(
        entity.message,
        equals('ADB Direct Mode active via granted daemon'),
      );
    });

    test('parseLogLine handles unparseable log lines gracefully', () {
      const rawLine = 'Some random non-standard system log output';

      final entity = LogcatService.parseLogLine(rawLine);

      expect(entity.pid, equals(0));
      expect(entity.tid, equals(0));
      expect(entity.level, equals(LogLevel.info));
      expect(entity.tag, equals('System'));
      expect(entity.message, equals(rawLine));
    });

    test(
      'streamLogs emits fallback log items on non-Android platform',
      () async {
        final stream = LogcatService.streamLogs();
        final firstLog = await stream.first;

        expect(firstLog.tag, isNotEmpty);
        expect(firstLog.message, isNotEmpty);
      },
    );
  });
}
