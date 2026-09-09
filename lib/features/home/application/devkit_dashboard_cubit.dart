import 'dart:async';

import 'package:devkit/core/services/device_info_service.dart';
import 'package:devkit/core/services/permission_service.dart';
import 'package:devkit/core/services/ping_service.dart';
import 'package:devkit/core/services/system_settings_service.dart';
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
  Timer? _pingTimer;
  Timer? _settingsTimer;

  Future<void> _initDashboard() async {
    final infoResult = await homeRepository.getDeviceInfo();
    final info = infoResult.data ??
        const DeviceInfoData(
          brand: 'Unknown',
          model: 'Device',
          sdkVersion: 0,
          ipAddress: '0.0.0.0',
        );

    final settingsResult = await homeRepository.getSystemSettings();
    final systemSettings =
        settingsResult.data ?? SystemSettingsData.fallback;

    final isAdbGranted =
        await PermissionService.isWriteSecureSettingsGranted();

    emit(
      state.copyWith(
        consoleState: state.consoleState.copyWith(
          deviceModel: info.model,
          deviceIp: info.ipAddress,
          sdkVersion: info.sdkVersion,
          isAdbGrantMode: isAdbGranted,
          isDevOptionsOn: systemSettings.isDevOptionsOn,
          isUsbDebuggingOn: systemSettings.isUsbDebuggingOn,
          isWirelessDebuggingOn: systemSettings.isWirelessDebuggingOn,
          devicePort: systemSettings.adbPort,
        ),
      ),
    );

    _settingsTimer?.cancel();
    _settingsTimer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => unawaited(_refreshSystemSettings()),
    );
  }

  Future<void> _refreshSystemSettings() async {
    if (isClosed) return;
    final settingsResult = await homeRepository.getSystemSettings();
    if (settingsResult.isSuccess && settingsResult.data != null) {
      final systemSettings = settingsResult.data!;
      emit(
        state.copyWith(
          consoleState: state.consoleState.copyWith(
            isDevOptionsOn: systemSettings.isDevOptionsOn,
            isUsbDebuggingOn: systemSettings.isUsbDebuggingOn,
            isWirelessDebuggingOn: systemSettings.isWirelessDebuggingOn,
            devicePort: systemSettings.adbPort,
          ),
        ),
      );
    }
  }

  Future<void> checkPermissions() async {
    final isAdbGranted =
        await PermissionService.isWriteSecureSettingsGranted();
    final settingsResult = await homeRepository.getSystemSettings();
    final systemSettings =
        settingsResult.data ?? SystemSettingsData.fallback;

    emit(
      state.copyWith(
        consoleState: state.consoleState.copyWith(
          isAdbGrantMode: isAdbGranted,
          isDevOptionsOn: systemSettings.isDevOptionsOn,
          isUsbDebuggingOn: systemSettings.isUsbDebuggingOn,
          isWirelessDebuggingOn: systemSettings.isWirelessDebuggingOn,
          devicePort: systemSettings.adbPort,
        ),
      ),
    );
  }

  static const String _blockedMsg =
      'Direct setting write blocked by Android. Opened Developer Settings.';

  Future<void> toggleDevOptions({required bool value}) async {
    if (!state.consoleState.isAdbGrantMode) {
      emit(
        state.copyWith(
          errorMessage: 'Direct ADB mode required to toggle Developer Options.',
        ),
      );
      return;
    }
    final result = await homeRepository.setDevOptions(enabled: value);
    if (result.isFailure || result.data != true) {
      emit(
        state.copyWith(
          errorMessage: result.failure?.message ?? _blockedMsg,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        consoleState: state.consoleState.copyWith(isDevOptionsOn: value),
        successMessage:
            'Developer Options ${value ? 'ENABLED' : 'DISABLED'}',
      ),
    );
  }

  Future<void> toggleUsbDebugging({required bool value}) async {
    if (!state.consoleState.isAdbGrantMode) {
      emit(
        state.copyWith(
          errorMessage: 'Direct ADB mode required to toggle USB Debugging.',
        ),
      );
      return;
    }
    final result = await homeRepository.setUsbDebugging(enabled: value);
    if (result.isFailure || result.data != true) {
      emit(
        state.copyWith(
          errorMessage: result.failure?.message ?? _blockedMsg,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        consoleState: state.consoleState.copyWith(isUsbDebuggingOn: value),
        successMessage: 'USB Debugging ${value ? 'ENABLED' : 'DISABLED'}',
      ),
    );
  }

  Future<void> toggleWirelessDebugging({required bool value}) async {
    if (!state.consoleState.isAdbGrantMode) {
      emit(
        state.copyWith(
          errorMessage:
              'Direct ADB mode required to toggle Wireless Debugging.',
        ),
      );
      return;
    }
    final result = await homeRepository.setWirelessDebugging(enabled: value);
    if (result.isFailure || result.data != true) {
      emit(
        state.copyWith(
          errorMessage: result.failure?.message ?? _blockedMsg,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        consoleState:
            state.consoleState.copyWith(isWirelessDebuggingOn: value),
        successMessage:
            'Wireless Debugging ${value ? 'ENABLED' : 'DISABLED'}',
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
    final nextState = !state.consoleState.isPingActive;
    _pingTimer?.cancel();

    if (!nextState) {
      emit(
        state.copyWith(
          consoleState: state.consoleState.copyWith(
            isPingActive: false,
            rttMs: 0,
            packetsSent: 0,
            packetsReceived: 0,
            packetLossPercent: 0,
          ),
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        consoleState: state.consoleState.copyWith(isPingActive: true),
      ),
    );

    unawaited(_runPingIteration());
    _pingTimer = Timer.periodic(
      const Duration(milliseconds: 1500),
      (_) => unawaited(_runPingIteration()),
    );
  }

  Future<void> _runPingIteration() async {
    if (isClosed || !state.consoleState.isPingActive) return;

    final currentSent = state.consoleState.packetsSent;
    final currentRecv = state.consoleState.packetsReceived;
    const target = '8.8.8.8';

    final result = await PingService.pingHost(
      host: target,
      currentSent: currentSent,
      currentRecv: currentRecv,
    );

    if (isClosed || !state.consoleState.isPingActive) return;

    emit(
      state.copyWith(
        consoleState: state.consoleState.copyWith(
          rttMs: result.rttMs,
          packetsSent: result.packetsSent,
          packetsReceived: result.packetsReceived,
          packetLossPercent: result.packetLossPercent,
        ),
      ),
    );
  }

  @override
  Future<void> close() async {
    _pingTimer?.cancel();
    _settingsTimer?.cancel();
    await super.close();
  }
}
