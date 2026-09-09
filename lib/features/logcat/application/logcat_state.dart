import 'package:devkit/features/logcat/domain/entities/logcat_log_entity.dart';
import 'package:devkit/features/logcat/domain/services/logcat_parser_service.dart';

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
    return LogcatParserService.filterLogs(
      logs: logs,
      selectedLevel: selectedLevel,
      searchQuery: filterQuery,
    );
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
