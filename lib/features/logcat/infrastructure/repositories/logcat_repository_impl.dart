import 'package:devkit/core/utils/safe_call.dart';
import 'package:devkit/features/logcat/domain/entities/logcat_log_entity.dart';
import 'package:devkit/features/logcat/domain/repositories/logcat_repository.dart';
import 'package:devkit/features/logcat/infrastructure/datasources/logcat_local_data_source.dart';

class LogcatRepositoryImpl implements LogcatRepository {
  const new({required this.localDataSource});

  final LogcatLocalDataSource localDataSource;

  @override
  Future<Result<List<LogcatLogEntity>>> getInitialLogs() {
    return safeCall(localDataSource.getLogs);
  }

  @override
  Stream<LogcatLogEntity> streamLogs() {
    return localDataSource.streamLogs();
  }
}
