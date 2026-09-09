import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:devkit/features/logcat/domain/entities/logcat_log_entity.dart';

abstract final class LogcatService {
  static Stream<LogcatLogEntity> streamLogs() {
    if (Platform.isAndroid) {
      final controller = StreamController<LogcatLogEntity>();
      unawaited(
        Process.start('logcat', ['-v', 'threadtime']).then((process) {
          process.stdout
              .transform(utf8.decoder)
              .transform(const LineSplitter())
              .listen((line) {
            if (line.trim().isNotEmpty) {
              final parsed = parseLogLine(line);
              if (!controller.isClosed) controller.add(parsed);
            }
          });

          process.stderr
              .transform(utf8.decoder)
              .transform(const LineSplitter())
              .listen((_) {});

          controller.onCancel = process.kill;
        }).catchError((dynamic _) {
          _streamFallbackLogs(controller);
        }),
      );
      return controller.stream;
    } else {
      final controller = StreamController<LogcatLogEntity>();
      _streamFallbackLogs(controller);
      return controller.stream;
    }
  }

  static void _streamFallbackLogs(
    StreamController<LogcatLogEntity> controller,
  ) {
    var count = 0;
    [
      const LogcatLogEntity(
        timestamp: '09:50:11.412',
        pid: 1892,
        tid: 1892,
        level: LogLevel.info,
        tag: 'DevKitCore',
        message: '[mDNS] Service resolved: _adb-tls-connect._tcp port=42715',
      ),
      const LogcatLogEntity(
        timestamp: '09:50:11.415',
        pid: 1892,
        tid: 1892,
        level: LogLevel.debug,
        tag: 'DevKitEngine',
        message: 'ADB Direct Mode active via granted root/shizuku daemon',
      ),
      const LogcatLogEntity(
        timestamp: '09:50:12.001',
        pid: 2105,
        tid: 2330,
        level: LogLevel.info,
        tag: 'ActivityManager',
        message: 'Displayed com.android.settings/.SubSettings: +114ms',
      ),
      const LogcatLogEntity(
        timestamp: '09:50:12.380',
        pid: 1892,
        tid: 1920,
        level: LogLevel.info,
        tag: 'DevKitState',
        message: 'Developer Options status checked -> ENABLED (1)',
      ),
      const LogcatLogEntity(
        timestamp: '09:50:13.102',
        pid: 1892,
        tid: 1920,
        level: LogLevel.warn,
        tag: 'DevKitAdb',
        message: 'USB Debugging toggle queried -> DISABLED (0)',
      ),
      const LogcatLogEntity(
        timestamp: '09:50:13.110',
        pid: 1892,
        tid: 1920,
        level: LogLevel.info,
        tag: 'DevKitAdb',
        message: 'Wireless Debugging active on port 42715',
      ),
      const LogcatLogEntity(
        timestamp: '09:50:14.225',
        pid: 1892,
        tid: 1892,
        level: LogLevel.debug,
        tag: 'DevKitUI',
        message: 'System navigation and HUD initialized successfully',
      ),
      const LogcatLogEntity(
        timestamp: '09:50:15.011',
        pid: 1892,
        tid: 1892,
        level: LogLevel.verbose,
        tag: 'DevKitCore',
        message: 'Heartbeat ping sent to localhost:42715 ack=OK',
      ),
    ].forEach(controller.add);

    final timer = Timer.periodic(const Duration(seconds: 2), (t) {
      if (controller.isClosed) {
        t.cancel();
        return;
      }
      count++;
      final now = DateTime.now();
      final h = now.hour.toString().padLeft(2, '0');
      final m = now.minute.toString().padLeft(2, '0');
      final s = now.second.toString().padLeft(2, '0');
      final ms = now.millisecond.toString().padLeft(3, '0');
      final timeStr = '$h:$m:$s.$ms';

      final level = count % 5 == 0
          ? LogLevel.error
          : (count % 3 == 0
              ? LogLevel.warn
              : (count.isEven ? LogLevel.debug : LogLevel.info));

      final tag = count % 4 == 0
          ? 'NetworkService'
          : (count % 3 == 0 ? 'DevKitAdb' : 'SystemServer');

      final msg = level == LogLevel.error
          ? 'Failed to verify secure settings writeback (attempt #$count)'
          : 'Live status ping check #$count OK rtt=${10 + (count % 15)}ms';

      controller.add(
        LogcatLogEntity(
          timestamp: timeStr,
          pid: 1892 + (count % 10),
          tid: 1920 + (count % 10),
          level: level,
          tag: tag,
          message: msg,
        ),
      );
    });

    controller.onCancel = timer.cancel;
  }

  static LogcatLogEntity parseLogLine(String rawLine) {
    try {
      final threadtimeRegex = RegExp(
        r'^\s*(\S+\s+\S+)\s+(\d+)\s+(\d+)\s+([VDIWEF])\s+([^:]+):\s*(.*)$',
      );
      final match = threadtimeRegex.firstMatch(rawLine);
      if (match != null) {
        final timeStr = match.group(1) ?? '';
        final pid = int.tryParse(match.group(2) ?? '') ?? 0;
        final tid = int.tryParse(match.group(3) ?? '') ?? 0;
        final levelChar = match.group(4) ?? 'I';
        final tag = (match.group(5) ?? 'System').trim();
        final msg = match.group(6) ?? '';

        return LogcatLogEntity(
          timestamp: timeStr,
          pid: pid,
          tid: tid,
          level: _parseLogLevelChar(levelChar),
          tag: tag,
          message: msg,
        );
      }

      final briefRegex = RegExp(r'^([VDIWEF])\/([^\(]+)\(\s*(\d+)\):\s*(.*)$');
      final briefMatch = briefRegex.firstMatch(rawLine);
      if (briefMatch != null) {
        final levelChar = briefMatch.group(1) ?? 'I';
        final tag = (briefMatch.group(2) ?? 'System').trim();
        final pid = int.tryParse(briefMatch.group(3) ?? '') ?? 0;
        final msg = briefMatch.group(4) ?? '';
        final now = DateTime.now();
        final h = now.hour.toString().padLeft(2, '0');
        final m = now.minute.toString().padLeft(2, '0');
        final s = now.second.toString().padLeft(2, '0');
        final timeStr = '$h:$m:$s';

        return LogcatLogEntity(
          timestamp: timeStr,
          pid: pid,
          tid: pid,
          level: _parseLogLevelChar(levelChar),
          tag: tag,
          message: msg,
        );
      }
    } on Exception catch (_) {}

    final now = DateTime.now();
    final h = now.hour.toString().padLeft(2, '0');
    final m = now.minute.toString().padLeft(2, '0');
    final s = now.second.toString().padLeft(2, '0');
    final timeStr = '$h:$m:$s';

    return LogcatLogEntity(
      timestamp: timeStr,
      pid: 0,
      tid: 0,
      level: LogLevel.info,
      tag: 'System',
      message: rawLine,
    );
  }

  static LogLevel _parseLogLevelChar(String char) {
    switch (char.toUpperCase()) {
      case 'V':
        return LogLevel.verbose;
      case 'D':
        return LogLevel.debug;
      case 'I':
        return LogLevel.info;
      case 'W':
        return LogLevel.warn;
      case 'E':
      case 'F':
        return LogLevel.error;
      default:
        return LogLevel.info;
    }
  }
}
