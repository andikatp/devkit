import 'dart:async';

import 'package:devkit/features/logcat/application/logcat_state.dart';
import 'package:devkit/features/logcat/domain/entities/logcat_log_entity.dart';
import 'package:devkit/features/logcat/domain/repositories/logcat_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogcatCubit extends Cubit<LogcatState> {
  new({
    required this.logcatRepository,
    LogcatState? initialState,
  }) : super(initialState ?? LogcatState(logs: [])) {
    unawaited(_initLogStream());
  }

  final LogcatRepository logcatRepository;
  StreamSubscription<LogcatLogEntity>? _logSubscription;
  Timer? _batchTimer;
  final List<LogcatLogEntity> _incomingBuffer = [];
  static const int _maxLogLimit = 1000;

  Future<void> _initLogStream() async {
    final initialLogs = await logcatRepository.getInitialLogs();
    emit(state.copyWith(logs: initialLogs));

    await _logSubscription?.cancel();
    _logSubscription = logcatRepository.streamLogs().listen(_onNewLogReceived);
  }

  void _onNewLogReceived(LogcatLogEntity newLog) {
    if (isClosed || state.isPaused) return;

    _incomingBuffer.add(newLog);
    _scheduleBatchFlush();
  }

  void _scheduleBatchFlush() {
    if (_batchTimer?.isActive ?? false) return;

    _batchTimer = Timer(const Duration(milliseconds: 100), _flushBatchBuffer);
  }

  void _flushBatchBuffer() {
    if (isClosed || _incomingBuffer.isEmpty) return;

    final currentLogs = List<LogcatLogEntity>.from(state.logs)
      ..addAll(_incomingBuffer);
    _incomingBuffer.clear();

    if (currentLogs.length > _maxLogLimit) {
      currentLogs.removeRange(0, currentLogs.length - _maxLogLimit);
    }

    emit(state.copyWith(logs: currentLogs));
  }

  void togglePause() {
    final nextPaused = !state.isPaused;
    emit(
      state.copyWith(
        isPaused: nextPaused,
        successMessage: nextPaused
            ? 'Logcat Stream PAUSED'
            : 'Logcat Stream RESUMED',
      ),
    );
  }

  void toggleAutoScroll() {
    final nextAutoScroll = !state.isAutoScrollEnabled;
    emit(
      state.copyWith(
        isAutoScrollEnabled: nextAutoScroll,
        successMessage:
            nextAutoScroll ? 'Auto-scroll ENABLED' : 'Auto-scroll DISABLED',
      ),
    );
  }

  void selectLogLevel({required LogLevel level}) {
    emit(state.copyWith(selectedLevel: level));
  }

  void updateFilter({required String query}) {
    emit(state.copyWith(filterQuery: query));
  }

  void clearLogs() {
    emit(
      state.copyWith(
        logs: const [],
        successMessage: 'Logs cleared',
      ),
    );
  }

  Future<void> copyLogs() async {
    final text = state.filteredLogs.map((l) => l.fullText).join('\n');
    await Clipboard.setData(ClipboardData(text: text));
    emit(
      state.copyWith(
        successMessage:
            'Copied ${state.filteredLogs.length} log lines to clipboard',
      ),
    );
  }

  Future<void> copyLogLine(LogcatLogEntity log) async {
    await Clipboard.setData(ClipboardData(text: log.fullText));
    emit(
      state.copyWith(
        successMessage: 'Copied log line to clipboard',
      ),
    );
  }

  @override
  Future<void> close() async {
    _batchTimer?.cancel();
    await _logSubscription?.cancel();
    await super.close();
  }
}
