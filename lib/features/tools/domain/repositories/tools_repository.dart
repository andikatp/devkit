import 'package:devkit/core/utils/safe_call.dart';
import 'package:devkit/features/tools/application/tools_state.dart';

abstract class ToolsRepository {
  Future<Result<ToolsState>> getInitialToolsState();
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
