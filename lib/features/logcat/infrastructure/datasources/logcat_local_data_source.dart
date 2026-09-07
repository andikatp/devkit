import 'package:devkit/features/logcat/domain/entities/logcat_log_entity.dart';

abstract class LogcatLocalDataSource {
  Future<List<LogcatLogEntity>> getLogs();
}

class LogcatLocalDataSourceImpl implements LogcatLocalDataSource {
  const new();

  @override
  Future<List<LogcatLogEntity>> getLogs() async {
    return const [
      LogcatLogEntity(
        timestamp: '09:50:11.412',
        pid: 1892,
        tid: 1892,
        level: LogLevel.info,
        tag: 'DevKitCore',
        message: '[mDNS] Service resolved: _adb-tls-connect._tcp port=42715',
      ),
      LogcatLogEntity(
        timestamp: '09:50:11.415',
        pid: 1892,
        tid: 1892,
        level: LogLevel.debug,
        tag: 'DevKitEngine',
        message: 'ADB Direct Mode active via granted root/shizuku daemon',
      ),
      LogcatLogEntity(
        timestamp: '09:50:12.001',
        pid: 2105,
        tid: 2330,
        level: LogLevel.info,
        tag: 'ActivityManager',
        message: 'Displayed com.android.settings/.SubSettings: +114ms',
      ),
      LogcatLogEntity(
        timestamp: '09:50:12.380',
        pid: 1892,
        tid: 1920,
        level: LogLevel.info,
        tag: 'DevKitState',
        message: 'Developer Options status checked -> ENABLED (1)',
      ),
      LogcatLogEntity(
        timestamp: '09:50:13.102',
        pid: 1892,
        tid: 1920,
        level: LogLevel.warn,
        tag: 'DevKitAdb',
        message: 'USB Debugging toggle queried -> DISABLED (0)',
      ),
      LogcatLogEntity(
        timestamp: '09:50:13.110',
        pid: 1892,
        tid: 1920,
        level: LogLevel.info,
        tag: 'DevKitAdb',
        message: 'Wireless Debugging active on port 42715',
      ),
      LogcatLogEntity(
        timestamp: '09:50:14.225',
        pid: 1892,
        tid: 1892,
        level: LogLevel.debug,
        tag: 'DevKitUI',
        message: 'System navigation and HUD initialized successfully',
      ),
      LogcatLogEntity(
        timestamp: '09:50:15.011',
        pid: 1892,
        tid: 1892,
        level: LogLevel.verbose,
        tag: 'DevKitCore',
        message: 'Heartbeat ping sent to localhost:42715 ack=OK',
      ),
    ];
  }
}
