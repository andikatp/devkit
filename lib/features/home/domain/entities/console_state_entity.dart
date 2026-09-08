class ConsoleStateEntity {
  const new({
    required this.isDevOptionsOn,
    required this.isUsbDebuggingOn,
    required this.isWirelessDebuggingOn,
    required this.isAdbGrantMode,
    required this.deviceIp,
    required this.devicePort,
    required this.deviceModel,
    required this.sdkVersion,
    this.isPingActive = false,
  });

  final bool isDevOptionsOn;
  final bool isUsbDebuggingOn;
  final bool isWirelessDebuggingOn;
  final bool isAdbGrantMode;
  final String deviceIp;
  final int devicePort;
  final String deviceModel;
  final int sdkVersion;
  final bool isPingActive;

  ConsoleStateEntity copyWith({
    bool? isDevOptionsOn,
    bool? isUsbDebuggingOn,
    bool? isWirelessDebuggingOn,
    bool? isAdbGrantMode,
    String? deviceIp,
    int? devicePort,
    String? deviceModel,
    int? sdkVersion,
    bool? isPingActive,
  }) {
    return ConsoleStateEntity(
      isDevOptionsOn: isDevOptionsOn ?? this.isDevOptionsOn,
      isUsbDebuggingOn: isUsbDebuggingOn ?? this.isUsbDebuggingOn,
      isWirelessDebuggingOn:
          isWirelessDebuggingOn ?? this.isWirelessDebuggingOn,
      isAdbGrantMode: isAdbGrantMode ?? this.isAdbGrantMode,
      deviceIp: deviceIp ?? this.deviceIp,
      devicePort: devicePort ?? this.devicePort,
      deviceModel: deviceModel ?? this.deviceModel,
      sdkVersion: sdkVersion ?? this.sdkVersion,
      isPingActive: isPingActive ?? this.isPingActive,
    );
  }
}

extension ConsoleStateEntityX on ConsoleStateEntity {
  String get modeText => isAdbGrantMode ? 'DIRECT' : 'SHORTCUT';
  String get footnoteText => isAdbGrantMode
      ? 'Flips instantly — DevKit holds SETTINGS'
      : 'Opens system page via INTENT SHORTCUT';
  String get adbConnectCommand => 'adb connect $deviceIp:$devicePort';
}
