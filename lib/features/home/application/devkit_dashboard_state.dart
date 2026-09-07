import 'package:devkit/features/home/domain/entities/console_state_entity.dart';

class DevKitDashboardState {
  const new({
    this.consoleState = const ConsoleStateEntity(
      isDevOptionsOn: true,
      isUsbDebuggingOn: false,
      isWirelessDebuggingOn: true,
      isAdbGrantMode: true,
      deviceIp: '10.42.217.117',
      devicePort: 42715,
      deviceModel: 'Samsung',
      sdkVersion: 34,
    ),
  });

  final ConsoleStateEntity consoleState;

  DevKitDashboardState copyWith({
    ConsoleStateEntity? consoleState,
  }) {
    return DevKitDashboardState(
      consoleState: consoleState ?? this.consoleState,
    );
  }
}
