class PermissionsState {
  const new({
    this.currentStep = 1,
    this.isNearbyWifiGranted = false,
    this.isNotificationGranted = false,
    this.isLocationGranted = false,
    this.isDirectModeGranted = false,
    this.isVerifying = false,
  });

  final int currentStep;
  final bool isNearbyWifiGranted;
  final bool isNotificationGranted;
  final bool isLocationGranted;
  final bool isDirectModeGranted;
  final bool isVerifying;

  PermissionsState copyWith({
    int? currentStep,
    bool? isNearbyWifiGranted,
    bool? isNotificationGranted,
    bool? isLocationGranted,
    bool? isDirectModeGranted,
    bool? isVerifying,
  }) {
    return PermissionsState(
      currentStep: currentStep ?? this.currentStep,
      isNearbyWifiGranted: isNearbyWifiGranted ?? this.isNearbyWifiGranted,
      isNotificationGranted:
          isNotificationGranted ?? this.isNotificationGranted,
      isLocationGranted: isLocationGranted ?? this.isLocationGranted,
      isDirectModeGranted: isDirectModeGranted ?? this.isDirectModeGranted,
      isVerifying: isVerifying ?? this.isVerifying,
    );
  }
}
