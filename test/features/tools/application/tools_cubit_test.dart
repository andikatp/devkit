import 'package:devkit/core/errors/failure.dart';
import 'package:devkit/core/utils/safe_call.dart';
import 'package:devkit/features/tools/application/tools_cubit.dart';
import 'package:devkit/features/tools/application/tools_state.dart';
import 'package:devkit/features/tools/domain/repositories/tools_repository.dart';
import 'package:flutter_test/flutter_test.dart';

class MockToolsRepository implements ToolsRepository {
  bool layoutBoundsVal = false;
  bool tapsVal = true;
  bool pointerLocationVal = false;
  double animationScaleVal = 1;
  bool stayAwakeVal = false;
  bool demoModeVal = false;
  bool forceDarkModeVal = false;
  double fontScaleVal = 1;
  bool gpuProfilingVal = false;
  bool strictModeVal = false;
  bool shouldFail = false;

  @override
  Future<Result<ToolsState>> getInitialToolsState() async {
    if (shouldFail) {
      return const Result<ToolsState>.failure(
        PlatformFailure(message: 'Failed to init'),
      );
    }
    return const Result<ToolsState>.success(ToolsState());
  }

  @override
  Future<Result<bool>> setLayoutBounds({required bool enabled}) async {
    if (shouldFail) {
      return const Result<bool>.failure(
        PlatformFailure(message: 'Failed to toggle'),
      );
    }
    layoutBoundsVal = enabled;
    return const Result<bool>.success(true);
  }

  @override
  Future<Result<bool>> setShowTaps({required bool enabled}) async {
    if (shouldFail) {
      return const Result<bool>.failure(
        PlatformFailure(message: 'Failed to toggle'),
      );
    }
    tapsVal = enabled;
    return const Result<bool>.success(true);
  }

  @override
  Future<Result<bool>> setPointerLocation({required bool enabled}) async {
    if (shouldFail) {
      return const Result<bool>.failure(
        PlatformFailure(message: 'Failed to toggle'),
      );
    }
    pointerLocationVal = enabled;
    return const Result<bool>.success(true);
  }

  @override
  Future<Result<bool>> setStayAwake({required bool enabled}) async {
    if (shouldFail) {
      return const Result<bool>.failure(
        PlatformFailure(message: 'Failed to toggle'),
      );
    }
    stayAwakeVal = enabled;
    return const Result<bool>.success(true);
  }

  @override
  Future<Result<bool>> setAnimationScale({required double scale}) async {
    if (shouldFail) {
      return const Result<bool>.failure(
        PlatformFailure(message: 'Failed to scale'),
      );
    }
    animationScaleVal = scale;
    return const Result<bool>.success(true);
  }

  @override
  Future<Result<bool>> setDemoMode({required bool enabled}) async {
    if (shouldFail) {
      return const Result<bool>.failure(
        PlatformFailure(message: 'Failed to toggle'),
      );
    }
    demoModeVal = enabled;
    return const Result<bool>.success(true);
  }

  @override
  Future<Result<bool>> setForceDarkMode({required bool enabled}) async {
    if (shouldFail) {
      return const Result<bool>.failure(
        PlatformFailure(message: 'Failed to toggle'),
      );
    }
    forceDarkModeVal = enabled;
    return const Result<bool>.success(true);
  }

  @override
  Future<Result<bool>> setFontScale({required double scale}) async {
    if (shouldFail) {
      return const Result<bool>.failure(
        PlatformFailure(message: 'Failed to scale'),
      );
    }
    fontScaleVal = scale;
    return const Result<bool>.success(true);
  }

  @override
  Future<Result<bool>> setGpuProfiling({required bool enabled}) async {
    if (shouldFail) {
      return const Result<bool>.failure(
        PlatformFailure(message: 'Failed to toggle'),
      );
    }
    gpuProfilingVal = enabled;
    return const Result<bool>.success(true);
  }

  @override
  Future<Result<bool>> setStrictMode({required bool enabled}) async {
    if (shouldFail) {
      return const Result<bool>.failure(
        PlatformFailure(message: 'Failed to toggle'),
      );
    }
    strictModeVal = enabled;
    return const Result<bool>.success(true);
  }
}

void main() {
  group('ToolsState', () {
    test('supports default values and copyWith', () {
      const state = ToolsState();
      expect(state.showLayoutBounds, isFalse);
      expect(state.showTaps, isTrue);
      expect(state.showPointerLocation, isFalse);
      expect(state.gpuProfiling, isFalse);
      expect(state.strictMode, isFalse);
      expect(state.animationScale, equals(1));
      expect(state.successMessage, null);
      expect(state.errorMessage, null);

      final updated = state.copyWith(
        showLayoutBounds: true,
        successMessage: 'Success',
      );
      expect(updated.showLayoutBounds, isTrue);
      expect(updated.showTaps, isTrue);
      expect(updated.successMessage, equals('Success'));
    });
  });

  group('ToolsCubit', () {
    late MockToolsRepository mockRepository;
    late ToolsCubit cubit;

    setUp(() {
      mockRepository = MockToolsRepository();
      cubit = ToolsCubit(toolsRepository: mockRepository);
    });

    tearDown(() async {
      await cubit.close();
    });

    test('initial state loads values from repository', () async {
      await Future<void>.delayed(Duration.zero);
      expect(cubit.state.showLayoutBounds, isFalse);
      expect(cubit.state.showTaps, isTrue);
    });

    test('toggleLayoutBounds updates state and successMessage', () async {
      await cubit.toggleLayoutBounds(value: true);
      expect(cubit.state.showLayoutBounds, isTrue);
      expect(
        cubit.state.successMessage,
        equals('Layout Bounds ENABLED'),
      );
      expect(mockRepository.layoutBoundsVal, isTrue);
    });

    test('toggleLayoutBounds emits errorMessage on failure', () async {
      mockRepository.shouldFail = true;
      await cubit.toggleLayoutBounds(value: true);
      expect(cubit.state.errorMessage, equals('Failed to toggle'));
    });

    test('toggleTaps updates state and successMessage', () async {
      await cubit.toggleTaps(value: false);
      expect(cubit.state.showTaps, isFalse);
      expect(
        cubit.state.successMessage,
        equals('Show Taps DISABLED'),
      );
      expect(mockRepository.tapsVal, isFalse);
    });

    test('togglePointerLocation updates state and successMessage', () async {
      await cubit.togglePointerLocation(value: true);
      expect(cubit.state.showPointerLocation, isTrue);
      expect(
        cubit.state.successMessage,
        equals('Pointer Location ENABLED'),
      );
      expect(mockRepository.pointerLocationVal, isTrue);
    });

    test('toggleGpuProfiling updates state and successMessage', () async {
      await cubit.toggleGpuProfiling(value: true);
      expect(cubit.state.gpuProfiling, isTrue);
      expect(
        cubit.state.successMessage,
        equals('GPU Profiling ENABLED'),
      );
      expect(mockRepository.gpuProfilingVal, isTrue);
    });

    test('toggleStrictMode updates state and successMessage', () async {
      await cubit.toggleStrictMode(value: true);
      expect(cubit.state.strictMode, isTrue);
      expect(
        cubit.state.successMessage,
        equals('Strict Mode Flashes ENABLED'),
      );
      expect(mockRepository.strictModeVal, isTrue);
    });

    test('setAnimationScale updates state and successMessage', () async {
      await cubit.setAnimationScale(scale: 2);
      expect(cubit.state.animationScale, equals(2));
      expect(
        cubit.state.successMessage,
        equals('Animation Scale set to 2.0x'),
      );
      expect(mockRepository.animationScaleVal, equals(2));
    });
  });
}
