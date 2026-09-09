import 'package:devkit/features/logcat/domain/entities/logcat_log_entity.dart';

abstract final class LogcatParserService {
  const new _();

  static List<LogcatLogEntity> filterLogs({
    required List<LogcatLogEntity> logs,
    required LogLevel selectedLevel,
    required String searchQuery,
  }) {
    final query = searchQuery.trim().toLowerCase();
    return logs.where((log) {
      if (log.level.index < selectedLevel.index) {
        return false;
      }
      if (query.isEmpty) return true;

      return log.tag.toLowerCase().contains(query) ||
          log.message.toLowerCase().contains(query);
    }).toList();
  }
}
