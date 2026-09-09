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
    this.rttMs = 0.0,
    this.packetsSent = 0,
    this.packetsReceived = 0,
    this.packetLossPercent = 0.0,
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
  final double rttMs;
  final int packetsSent;
  final int packetsReceived;
  final double packetLossPercent;

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
    double? rttMs,
    int? packetsSent,
    int? packetsReceived,
    double? packetLossPercent,
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
      rttMs: rttMs ?? this.rttMs,
      packetsSent: packetsSent ?? this.packetsSent,
      packetsReceived: packetsReceived ?? this.packetsReceived,
      packetLossPercent: packetLossPercent ?? this.packetLossPercent,
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
