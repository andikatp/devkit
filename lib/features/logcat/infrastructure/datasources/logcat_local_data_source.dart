import 'package:devkit/core/services/logcat_service.dart';
import 'package:devkit/features/logcat/domain/entities/logcat_log_entity.dart';

abstract class LogcatLocalDataSource {
  Future<List<LogcatLogEntity>> getLogs();
  Stream<LogcatLogEntity> streamLogs();
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
    ];
  }

  @override
  Stream<LogcatLogEntity> streamLogs() {
    return LogcatService.streamLogs();
  }
}
