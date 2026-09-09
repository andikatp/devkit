import 'package:devkit/core/utils/safe_call.dart';
import 'package:devkit/features/logcat/domain/entities/logcat_log_entity.dart';

abstract class LogcatRepository {
  Future<Result<List<LogcatLogEntity>>> getInitialLogs();
  Stream<LogcatLogEntity> streamLogs();
}
