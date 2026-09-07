import 'dart:async';

import 'package:devkit/features/home/application/devkit_dashboard_state.dart';
import 'package:devkit/features/home/domain/repositories/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DevKitDashboardCubit extends Cubit<DevKitDashboardState> {
  new({
    required this.homeRepository,
    DevKitDashboardState? initialState,
  }) : super(initialState ?? const .new()) {
    unawaited(_initDeviceInfo());
  }

  final HomeRepository homeRepository;

  Future<void> _initDeviceInfo() async {
    final info = await homeRepository.getDeviceInfo();
    emit(
      state.copyWith(
        consoleState: state.consoleState.copyWith(
          deviceModel: info.model,
          deviceIp: info.ipAddress,
          sdkVersion: info.sdkVersion,
        ),
      ),
    );
  }

  void toggleDevOptions({required bool value}) {
    emit(
      state.copyWith(
        consoleState: state.consoleState.copyWith(isDevOptionsOn: value),
      ),
    );
  }

  void toggleUsbDebugging({required bool value}) {
    emit(
      state.copyWith(
        consoleState: state.consoleState.copyWith(isUsbDebuggingOn: value),
      ),
    );
  }

  void toggleWirelessDebugging({required bool value}) {
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
