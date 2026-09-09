import 'package:devkit/features/logcat/domain/entities/logcat_log_entity.dart';

class LogcatState {
  new({
    required this.logs,
    List<LogcatLogEntity>? filteredLogs,
    this.selectedLevel = LogLevel.verbose,
    this.filterQuery = '',
    this.isPaused = false,
    this.isAutoScrollEnabled = true,
    this.successMessage,
    this.errorMessage,
  }) : filteredLogs = filteredLogs ??
            _computeFilteredLogs(logs, selectedLevel, filterQuery);

  final List<LogcatLogEntity> logs;
  final List<LogcatLogEntity> filteredLogs;
  final LogLevel selectedLevel;
  final String filterQuery;
  final bool isPaused;
  final bool isAutoScrollEnabled;
  final String? successMessage;
  final String? errorMessage;

  static List<LogcatLogEntity> _computeFilteredLogs(
    List<LogcatLogEntity> logs,
    LogLevel selectedLevel,
    String filterQuery,
  ) {
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
    bool? isPaused,
    bool? isAutoScrollEnabled,
    String? successMessage,
    String? errorMessage,
  }) {
    final nextLogs = logs ?? this.logs;
    final nextLevel = selectedLevel ?? this.selectedLevel;
    final nextQuery = filterQuery ?? this.filterQuery;
    final isFilterChanged = logs != null ||
        selectedLevel != null ||
        filterQuery != null;

    return LogcatState(
      logs: nextLogs,
      filteredLogs: isFilterChanged
          ? _computeFilteredLogs(nextLogs, nextLevel, nextQuery)
          : filteredLogs,
      selectedLevel: nextLevel,
      filterQuery: nextQuery,
      isPaused: isPaused ?? this.isPaused,
      isAutoScrollEnabled: isAutoScrollEnabled ?? this.isAutoScrollEnabled,
      successMessage: successMessage,
      errorMessage: errorMessage,
    );
  }
}
