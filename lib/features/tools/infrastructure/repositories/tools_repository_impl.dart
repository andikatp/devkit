import 'package:devkit/core/utils/safe_call.dart';
import 'package:devkit/features/tools/application/tools_state.dart';
import 'package:devkit/features/tools/domain/repositories/tools_repository.dart';
import 'package:devkit/features/tools/infrastructure/datasources/tools_local_data_source.dart';

class ToolsRepositoryImpl implements ToolsRepository {
  const new({required this.localDataSource});

  final ToolsLocalDataSource localDataSource;

  @override
  Future<Result<ToolsState>> getInitialToolsState() {
    return localDataSource.getToolsState();
  }

  @override
  Future<Result<bool>> setLayoutBounds({required bool enabled}) =>
      localDataSource.setLayoutBounds(enabled: enabled);

  @override
  Future<Result<bool>> setShowTaps({required bool enabled}) =>
      localDataSource.setShowTaps(enabled: enabled);

  @override
  Future<Result<bool>> setPointerLocation({required bool enabled}) =>
      localDataSource.setPointerLocation(enabled: enabled);

  @override
  Future<Result<bool>> setStayAwake({required bool enabled}) =>
      localDataSource.setStayAwake(enabled: enabled);

  @override
  Future<Result<bool>> setAnimationScale({required double scale}) =>
      localDataSource.setAnimationScale(scale: scale);

  @override
  Future<Result<bool>> setDemoMode({required bool enabled}) =>
      localDataSource.setDemoMode(enabled: enabled);

  @override
  Future<Result<bool>> setForceDarkMode({required bool enabled}) =>
      localDataSource.setForceDarkMode(enabled: enabled);

  @override
  Future<Result<bool>> setFontScale({required double scale}) =>
      localDataSource.setFontScale(scale: scale);

  @override
  Future<Result<bool>> setGpuProfiling({required bool enabled}) =>
      localDataSource.setGpuProfiling(enabled: enabled);

  @override
  Future<Result<bool>> setStrictMode({required bool enabled}) =>
      localDataSource.setStrictMode(enabled: enabled);
}
