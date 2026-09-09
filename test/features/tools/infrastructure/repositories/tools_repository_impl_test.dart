import 'package:devkit/core/utils/safe_call.dart';
import 'package:devkit/features/tools/application/tools_state.dart';
import 'package:devkit/features/tools/infrastructure/datasources/tools_local_data_source.dart';
import 'package:devkit/features/tools/infrastructure/repositories/tools_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

class MockToolsLocalDataSource implements ToolsLocalDataSource {
  bool layoutBoundsVal = false;
  bool tapsVal = true;
  bool pointerLocationVal = false;
  bool stayAwakeVal = false;
  double animationScaleVal = 1;
  bool demoModeVal = false;
  bool forceDarkModeVal = false;
  double fontScaleVal = 1;
  bool gpuProfilingVal = false;
  bool strictModeVal = false;

  @override
  Future<Result<ToolsState>> getToolsState() async {
    return const Result<ToolsState>.success(ToolsState());
  }

  @override
  Future<Result<bool>> setLayoutBounds({required bool enabled}) async {
    layoutBoundsVal = enabled;
    return const Result<bool>.success(true);
  }

  @override
  Future<Result<bool>> setShowTaps({required bool enabled}) async {
    tapsVal = enabled;
    return const Result<bool>.success(true);
  }

  @override
  Future<Result<bool>> setPointerLocation({required bool enabled}) async {
    pointerLocationVal = enabled;
    return const Result<bool>.success(true);
  }

  @override
  Future<Result<bool>> setStayAwake({required bool enabled}) async {
    stayAwakeVal = enabled;
    return const Result<bool>.success(true);
  }

  @override
  Future<Result<bool>> setAnimationScale({required double scale}) async {
    animationScaleVal = scale;
    return const Result<bool>.success(true);
  }

  @override
  Future<Result<bool>> setDemoMode({required bool enabled}) async {
    demoModeVal = enabled;
    return const Result<bool>.success(true);
  }

  @override
  Future<Result<bool>> setForceDarkMode({required bool enabled}) async {
    forceDarkModeVal = enabled;
    return const Result<bool>.success(true);
  }

  @override
  Future<Result<bool>> setFontScale({required double scale}) async {
    fontScaleVal = scale;
    return const Result<bool>.success(true);
  }

  @override
  Future<Result<bool>> setGpuProfiling({required bool enabled}) async {
    gpuProfilingVal = enabled;
    return const Result<bool>.success(true);
  }

  @override
  Future<Result<bool>> setStrictMode({required bool enabled}) async {
    strictModeVal = enabled;
    return const Result<bool>.success(true);
  }
}

void main() {
  group('ToolsRepositoryImpl', () {
    late MockToolsLocalDataSource mockDataSource;
    late ToolsRepositoryImpl repository;

    setUp(() {
      mockDataSource = MockToolsLocalDataSource();
      repository = ToolsRepositoryImpl(localDataSource: mockDataSource);
    });

    test('getInitialToolsState returns state wrapped in Result.success',
        () async {
      final result = await repository.getInitialToolsState();
      expect(result.isSuccess, isTrue);
      final state = result.data!;
      expect(state.showLayoutBounds, isFalse);
      expect(state.showTaps, isTrue);
      expect(state.showPointerLocation, isFalse);
      expect(state.gpuProfiling, isFalse);
      expect(state.strictMode, isFalse);
      expect(state.animationScale, equals(1));
    });

    test('setLayoutBounds delegates call and returns Result.success', () async {
      final result = await repository.setLayoutBounds(enabled: true);
      expect(result.isSuccess, isTrue);
      expect(result.data, isTrue);
      expect(mockDataSource.layoutBoundsVal, isTrue);
    });

    test('setShowTaps delegates call and returns Result.success', () async {
      final result = await repository.setShowTaps(enabled: false);
      expect(result.isSuccess, isTrue);
      expect(result.data, isTrue);
      expect(mockDataSource.tapsVal, isFalse);
    });

    test('setPointerLocation delegates call and returns Result.success',
        () async {
      final result = await repository.setPointerLocation(enabled: true);
      expect(result.isSuccess, isTrue);
      expect(result.data, isTrue);
      expect(mockDataSource.pointerLocationVal, isTrue);
    });

    test('setAnimationScale delegates call and returns Result.success',
        () async {
      final result = await repository.setAnimationScale(scale: 2);
      expect(result.isSuccess, isTrue);
      expect(result.data, isTrue);
      expect(mockDataSource.animationScaleVal, equals(2));
    });

    test('setGpuProfiling delegates call and returns Result.success',
        () async {
      final result = await repository.setGpuProfiling(enabled: true);
      expect(result.isSuccess, isTrue);
      expect(result.data, isTrue);
      expect(mockDataSource.gpuProfilingVal, isTrue);
    });

    test('setStrictMode delegates call and returns Result.success', () async {
      final result = await repository.setStrictMode(enabled: true);
      expect(result.isSuccess, isTrue);
      expect(result.data, isTrue);
      expect(mockDataSource.strictModeVal, isTrue);
    });
  });
}
