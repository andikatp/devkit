import 'dart:async';

import 'package:devkit/features/logcat/application/logcat_cubit.dart';
import 'package:devkit/features/logcat/domain/entities/logcat_log_entity.dart';
import 'package:devkit/features/logcat/domain/repositories/logcat_repository.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeLogcatRepository implements LogcatRepository {
  final _controller = StreamController<LogcatLogEntity>.broadcast();

  void emitTestLog(LogcatLogEntity log) {
    _controller.add(log);
  }

  @override
  Future<List<LogcatLogEntity>> getInitialLogs() async {
    return const [
      LogcatLogEntity(
        timestamp: '09:50:11.412',
        pid: 1892,
        tid: 1892,
        level: LogLevel.info,
        tag: 'TestTag',
        message: 'Initial test log',
      ),
    ];
  }

  @override
  Stream<LogcatLogEntity> streamLogs() => _controller.stream;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LogcatCubit', () {
    late FakeLogcatRepository repository;
    late LogcatCubit cubit;

    setUp(() {
      repository = FakeLogcatRepository();
      cubit = LogcatCubit(logcatRepository: repository);
    });

    tearDown(() async {
      await cubit.close();
    });

    test('initial state loads initial logs from repository', () async {
      await Future<void>.delayed(const Duration(milliseconds: 10));
      expect(cubit.state.logs.length, equals(1));
      expect(cubit.state.logs.first.tag, equals('TestTag'));
    });

    test('togglePause toggles isPaused and updates successMessage', () {
      cubit.togglePause();
      expect(cubit.state.isPaused, isTrue);
      expect(cubit.state.successMessage, equals('Logcat Stream PAUSED'));

      cubit.togglePause();
      expect(cubit.state.isPaused, isFalse);
      expect(cubit.state.successMessage, equals('Logcat Stream RESUMED'));
    });

    test('toggleAutoScroll toggles isAutoScrollEnabled', () {
      cubit.toggleAutoScroll();
      expect(cubit.state.isAutoScrollEnabled, isFalse);
      expect(cubit.state.successMessage, equals('Auto-scroll DISABLED'));

      cubit.toggleAutoScroll();
      expect(cubit.state.isAutoScrollEnabled, isTrue);
      expect(cubit.state.successMessage, equals('Auto-scroll ENABLED'));
    });

    test('selectLogLevel filters logs by severity', () {
      cubit.selectLogLevel(level: LogLevel.error);
      expect(cubit.state.selectedLevel, equals(LogLevel.error));
      expect(cubit.state.filteredLogs, isEmpty);
    });

    test('updateFilter filters logs by tag or message query', () {
      cubit.updateFilter(query: 'Initial');
      expect(cubit.state.filteredLogs.length, equals(1));

      cubit.updateFilter(query: 'NonExistent');
      expect(cubit.state.filteredLogs, isEmpty);
    });

    test('clearLogs empties log buffer', () {
      cubit.clearLogs();
      expect(cubit.state.logs, isEmpty);
      expect(cubit.state.successMessage, equals('Logs cleared'));
    });
  });
}
