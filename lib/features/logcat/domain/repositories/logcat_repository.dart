import 'package:devkit/features/logcat/domain/entities/logcat_log_entity.dart';

abstract class LogcatRepository {
  Future<List<LogcatLogEntity>> getInitialLogs();
}
