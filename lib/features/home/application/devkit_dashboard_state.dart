import 'package:devkit/features/home/domain/entities/console_state_entity.dart';

class DevKitDashboardState {
  const new({
    this.consoleState = const ConsoleStateEntity(
      isDevOptionsOn: true,
      isUsbDebuggingOn: false,
      isWirelessDebuggingOn: true,
      isAdbGrantMode: true,
      deviceIp: '127.0.0.1',
      devicePort: 5555,
      deviceModel: 'Device',
      sdkVersion: 34,
    ),
    this.successMessage,
    this.errorMessage,
  });

  final ConsoleStateEntity consoleState;
  final String? successMessage;
  final String? errorMessage;

  DevKitDashboardState copyWith({
    ConsoleStateEntity? consoleState,
    String? successMessage,
    String? errorMessage,
  }) {
    return DevKitDashboardState(
      consoleState: consoleState ?? this.consoleState,
      successMessage: successMessage,
      errorMessage: errorMessage,
    );
  }
}
