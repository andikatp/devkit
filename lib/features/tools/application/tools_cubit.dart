import 'dart:async';

import 'package:devkit/core/services/permission_service.dart';
import 'package:devkit/features/tools/application/tools_state.dart';
import 'package:devkit/features/tools/domain/repositories/tools_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToolsCubit extends Cubit<ToolsState> {
  new({required this.toolsRepository, ToolsState? initialState})
    : super(initialState ?? const ToolsState()) {
    unawaited(_initTools());
  }

  final ToolsRepository toolsRepository;

  static const String adbCommandString =
      'adb shell pm grant com.andikatp.devkit '
      'android.permission.WRITE_SECURE_SETTINGS';

  static const String _blockedMsg =
      'Direct setting write blocked by Android. Opened Developer Settings. '
      'Grant WRITE_SECURE_SETTINGS via ADB for 1-tap toggles.';

  Future<void> _initTools() async {
    final isAdbGranted =
        await PermissionService.isWriteSecureSettingsGranted();
    final result = await toolsRepository.getInitialToolsState();
    final data = result.data;
    if (result.isSuccess && data != null) {
      emit(data.copyWith(isAdbGranted: isAdbGranted));
    } else if (result.isFailure) {
      emit(
        state.copyWith(
          isAdbGranted: isAdbGranted,
          errorMessage: result.failure?.message,
        ),
      );
    } else {
      emit(state.copyWith(isAdbGranted: isAdbGranted));
    }
  }

  Future<void> refreshAdbStatus() async {
    final isGranted = await PermissionService.isWriteSecureSettingsGranted();
    emit(state.copyWith(isAdbGranted: isGranted));
  }

  Future<void> copyAdbCommand() async {
    await Clipboard.setData(const ClipboardData(text: adbCommandString));
    emit(
      state.copyWith(
        successMessage: 'Copied ADB permission command to clipboard',
      ),
    );
  }

  Future<void> openDeveloperSettings() async {
    await PermissionService.openDeveloperSettings();
  }

  Future<void> toggleLayoutBounds({required bool value}) async {
    final result = await toolsRepository.setLayoutBounds(enabled: value);
    if (result.isFailure || result.data != true) {
      await PermissionService.openDeveloperSettings();
      emit(
        state.copyWith(
          errorMessage: result.failure?.message ?? _blockedMsg,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        showLayoutBounds: value,
        successMessage: 'Layout Bounds ${value ? 'ENABLED' : 'DISABLED'}',
      ),
    );
  }

  Future<void> toggleTaps({required bool value}) async {
    final result = await toolsRepository.setShowTaps(enabled: value);
    if (result.isFailure || result.data != true) {
      await PermissionService.openDeveloperSettings();
      emit(
        state.copyWith(
          errorMessage: result.failure?.message ?? _blockedMsg,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        showTaps: value,
        successMessage: 'Show Taps ${value ? 'ENABLED' : 'DISABLED'}',
      ),
    );
  }

  Future<void> togglePointerLocation({required bool value}) async {
    final result = await toolsRepository.setPointerLocation(enabled: value);
    if (result.isFailure || result.data != true) {
      await PermissionService.openDeveloperSettings();
      emit(
        state.copyWith(
          errorMessage: result.failure?.message ?? _blockedMsg,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        showPointerLocation: value,
        successMessage: 'Pointer Location ${value ? 'ENABLED' : 'DISABLED'}',
      ),
    );
  }

  Future<void> toggleStayAwake({required bool value}) async {
    final result = await toolsRepository.setStayAwake(enabled: value);
    if (result.isFailure || result.data != true) {
      await PermissionService.openDeveloperSettings();
      emit(
        state.copyWith(
          errorMessage: result.failure?.message ?? _blockedMsg,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        stayAwake: value,
        successMessage:
            'Stay Awake While Plugged In ${value ? 'ENABLED' : 'DISABLED'}',
      ),
    );
  }

  Future<void> toggleDemoMode({required bool value}) async {
    final result = await toolsRepository.setDemoMode(enabled: value);
    if (result.isFailure || result.data != true) {
      await PermissionService.openDeveloperSettings();
      emit(
        state.copyWith(
          errorMessage: result.failure?.message ?? _blockedMsg,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        demoMode: value,
        successMessage: 'System Demo Mode ${value ? 'ENABLED' : 'DISABLED'}',
      ),
    );
  }

  Future<void> toggleForceDarkMode({required bool value}) async {
    final result = await toolsRepository.setForceDarkMode(enabled: value);
    if (result.isFailure || result.data != true) {
      await PermissionService.openDeveloperSettings();
      emit(
        state.copyWith(
          errorMessage: result.failure?.message ?? _blockedMsg,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        forceDarkMode: value,
        successMessage:
            'Force System Dark Theme ${value ? 'ENABLED' : 'DISABLED'}',
      ),
    );
  }

  Future<void> setFontScale({required double scale}) async {
    final result = await toolsRepository.setFontScale(scale: scale);
    if (result.isFailure || result.data != true) {
      await PermissionService.openDeveloperSettings();
      emit(
        state.copyWith(
          errorMessage: result.failure?.message ?? _blockedMsg,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        fontScale: scale,
        successMessage: 'Font Scale set to ${scale}x',
      ),
    );
  }

  Future<void> toggleGpuProfiling({required bool value}) async {
    final result = await toolsRepository.setGpuProfiling(enabled: value);
    if (result.isFailure || result.data != true) {
      await PermissionService.openDeveloperSettings();
      emit(
        state.copyWith(
          errorMessage: result.failure?.message ?? _blockedMsg,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        gpuProfiling: value,
        successMessage: 'GPU Profiling ${value ? 'ENABLED' : 'DISABLED'}',
      ),
    );
  }

  Future<void> toggleStrictMode({required bool value}) async {
    final result = await toolsRepository.setStrictMode(enabled: value);
    if (result.isFailure || result.data != true) {
      await PermissionService.openDeveloperSettings();
      emit(
        state.copyWith(
          errorMessage: result.failure?.message ?? _blockedMsg,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        strictMode: value,
        successMessage: 'Strict Mode Flashes ${value ? 'ENABLED' : 'DISABLED'}',
      ),
    );
  }

  Future<void> setAnimationScale({required double scale}) async {
    final result = await toolsRepository.setAnimationScale(scale: scale);
    if (result.isFailure || result.data != true) {
      await PermissionService.openDeveloperSettings();
      emit(
        state.copyWith(
          errorMessage: result.failure?.message ?? _blockedMsg,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        animationScale: scale,
        successMessage: 'Animation Scale set to ${scale}x',
      ),
    );
  }
}
