import 'dart:async';

import 'package:devkit/features/logcat/application/logcat_state.dart';
import 'package:devkit/features/logcat/domain/entities/logcat_log_entity.dart';
import 'package:devkit/features/logcat/domain/repositories/logcat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogcatCubit extends Cubit<LogcatState> {
  new({
    required this.logcatRepository,
    LogcatState? initialState,
  }) : super(initialState ?? const .new(logs: [])) {
    unawaited(_loadLogs());
  }

  final LogcatRepository logcatRepository;

  Future<void> _loadLogs() async {
    final logs = await logcatRepository.getInitialLogs();
    emit(state.copyWith(logs: logs));
  }

  void selectLogLevel({required LogLevel level}) {
    emit(state.copyWith(selectedLevel: level));
  }

  void updateFilter({required String query}) {
    emit(state.copyWith(filterQuery: query));
  }

  void clearLogs() {
    emit(state.copyWith(logs: const []));
  }
}
