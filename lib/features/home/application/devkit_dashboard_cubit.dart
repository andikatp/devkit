import 'dart:async';

import 'package:devkit/core/services/permission_service.dart';
import 'package:devkit/features/home/application/devkit_dashboard_state.dart';
import 'package:devkit/features/home/domain/repositories/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DevKitDashboardCubit extends Cubit<DevKitDashboardState> {
  new({
    required this.homeRepository,
    DevKitDashboardState? initialState,
  }) : super(initialState ?? const .new()) {
    unawaited(_initDashboard());
  }

  final HomeRepository homeRepository;

  Future<void> _initDashboard() async {
    final info = await homeRepository.getDeviceInfo();
    final isAdbGranted = await PermissionService.isWriteSecureSettingsGranted();

    emit(
      state.copyWith(
        consoleState: state.consoleState.copyWith(
          deviceModel: info.model,
          deviceIp: info.ipAddress,
          sdkVersion: info.sdkVersion,
          isAdbGrantMode: isAdbGranted,
        ),
      ),
    );
  }

  Future<void> checkPermissions() async {
    final isAdbGranted = await PermissionService.isWriteSecureSettingsGranted();
    emit(
      state.copyWith(
        consoleState: state.consoleState.copyWith(
          isAdbGrantMode: isAdbGranted,
        ),
      ),
    );
  }

  Future<void> toggleDevOptions({required bool value}) async {
    if (!state.consoleState.isAdbGrantMode) {
      await PermissionService.openDeveloperSettings();
      return;
    }
    emit(
      state.copyWith(
        consoleState: state.consoleState.copyWith(isDevOptionsOn: value),
      ),
    );
  }

  Future<void> toggleUsbDebugging({required bool value}) async {
    if (!state.consoleState.isAdbGrantMode) {
      await PermissionService.openDeveloperSettings();
      return;
    }
    emit(
      state.copyWith(
        consoleState: state.consoleState.copyWith(isUsbDebuggingOn: value),
      ),
    );
  }

  Future<void> toggleWirelessDebugging({required bool value}) async {
    if (!state.consoleState.isAdbGrantMode) {
      await PermissionService.openDeveloperSettings();
      return;
    }
    emit(
      state.copyWith(
        consoleState:
            state.consoleState.copyWith(isWirelessDebuggingOn: value),
      ),
    );
  }

  void toggleAdbGrantMode() {
    emit(
      state.copyWith(
        consoleState: state.consoleState.copyWith(
          isAdbGrantMode: !state.consoleState.isAdbGrantMode,
        ),
      ),
    );
  }

  void togglePing() {
    emit(
      state.copyWith(
        consoleState: state.consoleState.copyWith(
          isPingActive: !state.consoleState.isPingActive,
        ),
      ),
    );
  }
}
