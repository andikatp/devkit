import 'dart:async';

import 'package:devkit/core/services/permission_service.dart';
import 'package:devkit/features/permissions/application/permissions_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PermissionsCubit extends Cubit<PermissionsState> {
  new() : super(const .new()) {
    unawaited(checkInitialPermissions());
  }

  Timer? _pollingTimer;

  Future<void> checkInitialPermissions() async {
    final nearby = await PermissionService.isNearbyWifiGranted();
    final notif = await PermissionService.isNotificationGranted();
    final loc = await PermissionService.isLocationGranted();
    final direct = await PermissionService.isWriteSecureSettingsGranted();

    if (isClosed) return;

    emit(
      state.copyWith(
        isNearbyWifiGranted: nearby,
        isNotificationGranted: notif,
        isLocationGranted: loc,
        isDirectModeGranted: direct,
      ),
    );

    if (state.currentStep == 2 && !direct) {
      _startAutoPolling();
    }
  }

  Future<void> requestNearbyWifi() async {
    final granted = await PermissionService.requestNearbyWifi();
    emit(state.copyWith(isNearbyWifiGranted: granted));
  }

  Future<void> requestNotification() async {
    final granted = await PermissionService.requestNotification();
    emit(state.copyWith(isNotificationGranted: granted));
  }

  Future<void> requestLocation() async {
    final granted = await PermissionService.requestLocation();
    emit(state.copyWith(isLocationGranted: granted));
  }

  Future<void> verifyDirectModeGrant() async {
    emit(state.copyWith(isVerifying: true));
    await Future<void>.delayed(const Duration(milliseconds: 600));
    final granted = await PermissionService.isWriteSecureSettingsGranted();
    emit(state.copyWith(isDirectModeGranted: granted, isVerifying: false));
    if (granted) {
      _stopAutoPolling();
    }
  }

  void setStep(int step) {
    emit(state.copyWith(currentStep: step));
    if (step == 2 && !state.isDirectModeGranted) {
      _startAutoPolling();
    } else {
      _stopAutoPolling();
    }
  }

  void _startAutoPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(
      const Duration(seconds: 2),
      (_) async {
        if (state.isDirectModeGranted) {
          _stopAutoPolling();
          return;
        }
        final isGranted =
            await PermissionService.isWriteSecureSettingsGranted();
        if (isGranted && !isClosed) {
          _stopAutoPolling();
          emit(state.copyWith(isDirectModeGranted: true));
        }
      },
    );
  }

  void _stopAutoPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  @override
  Future<void> close() {
    _stopAutoPolling();
    return super.close();
  }
}
