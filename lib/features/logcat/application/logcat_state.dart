import 'package:devkit/features/logcat/domain/entities/logcat_log_entity.dart';

class LogcatState {
  const new({
    required this.logs,
    this.selectedLevel = LogLevel.info,
    this.filterQuery = '',
  });

  final List<LogcatLogEntity> logs;
  final LogLevel selectedLevel;
  final String filterQuery;

  List<LogcatLogEntity> get filteredLogs {
    return logs.where((log) {
      if (log.level.index < selectedLevel.index) return false;
      if (filterQuery.trim().isEmpty) return true;
      final q = filterQuery.toLowerCase();
      return log.tag.toLowerCase().contains(q) ||
          log.message.toLowerCase().contains(q);
    }).toList();
  }

  LogcatState copyWith({
    List<LogcatLogEntity>? logs,
    LogLevel? selectedLevel,
    String? filterQuery,
  }) {
    return LogcatState(
      logs: logs ?? this.logs,
      selectedLevel: selectedLevel ?? this.selectedLevel,
      filterQuery: filterQuery ?? this.filterQuery,
    );
  }
}
