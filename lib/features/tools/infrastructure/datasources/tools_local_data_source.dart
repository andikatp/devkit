import 'package:devkit/core/services/system_settings_service.dart';
import 'package:devkit/core/utils/safe_call.dart';
import 'package:devkit/features/tools/application/tools_state.dart';

abstract class ToolsLocalDataSource {
  Future<Result<ToolsState>> getToolsState();
  Future<Result<bool>> setLayoutBounds({required bool enabled});
  Future<Result<bool>> setShowTaps({required bool enabled});
  Future<Result<bool>> setPointerLocation({required bool enabled});
  Future<Result<bool>> setStayAwake({required bool enabled});
  Future<Result<bool>> setAnimationScale({required double scale});
  Future<Result<bool>> setDemoMode({required bool enabled});
  Future<Result<bool>> setForceDarkMode({required bool enabled});
  Future<Result<bool>> setFontScale({required double scale});
  Future<Result<bool>> setGpuProfiling({required bool enabled});
  Future<Result<bool>> setStrictMode({required bool enabled});
}

class ToolsLocalDataSourceImpl implements ToolsLocalDataSource {
  const new();

  @override
  Future<Result<ToolsState>> getToolsState() async {
    final result = await SystemSettingsService.getToolsStateMap();
    if (result.isFailure || result.data == null) {
      return const Result.success(ToolsState());
    }
    final map = result.data!;
    return Result.success(
      ToolsState(
        showTaps: (map['showTaps'] as bool?) ?? true,
        showPointerLocation: (map['showPointerLocation'] as bool?) ?? false,
        stayAwake: (map['stayAwake'] as bool?) ?? false,
        animationScale: (map['animationScale'] as double?) ?? 1.0,
        demoMode: (map['demoMode'] as bool?) ?? false,
        forceDarkMode: (map['forceDarkMode'] as bool?) ?? false,
        fontScale: (map['fontScale'] as double?) ?? 1.0,
      ),
    );
  }

  @override
  Future<Result<bool>> setLayoutBounds({required bool enabled}) =>
      SystemSettingsService.setLayoutBounds(enabled: enabled);

  @override
  Future<Result<bool>> setShowTaps({required bool enabled}) =>
      SystemSettingsService.setShowTaps(enabled: enabled);

  @override
  Future<Result<bool>> setPointerLocation({required bool enabled}) =>
      SystemSettingsService.setPointerLocation(enabled: enabled);

  @override
  Future<Result<bool>> setStayAwake({required bool enabled}) =>
      SystemSettingsService.setStayAwake(enabled: enabled);

  @override
  Future<Result<bool>> setAnimationScale({required double scale}) =>
      SystemSettingsService.setAnimationScale(scale: scale);

  @override
  Future<Result<bool>> setDemoMode({required bool enabled}) =>
      SystemSettingsService.setDemoMode(enabled: enabled);

  @override
  Future<Result<bool>> setForceDarkMode({required bool enabled}) =>
      SystemSettingsService.setForceDarkMode(enabled: enabled);

  @override
  Future<Result<bool>> setFontScale({required double scale}) =>
      SystemSettingsService.setFontScale(scale: scale);

  @override
  Future<Result<bool>> setGpuProfiling({required bool enabled}) =>
      SystemSettingsService.setGpuProfiling(enabled: enabled);

  @override
  Future<Result<bool>> setStrictMode({required bool enabled}) =>
      SystemSettingsService.setStrictMode(enabled: enabled);
}
