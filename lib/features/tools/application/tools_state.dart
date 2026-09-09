class ToolsState {
  const new({
    this.showLayoutBounds = false,
    this.showTaps = true,
    this.showPointerLocation = false,
    this.stayAwake = false,
    this.demoMode = false,
    this.forceDarkMode = false,
    this.fontScale = 1.0,
    this.gpuProfiling = false,
    this.strictMode = false,
    this.animationScale = 1.0,
    this.isAdbGranted = false,
    this.successMessage,
    this.errorMessage,
  });

  final bool showLayoutBounds;
  final bool showTaps;
  final bool showPointerLocation;
  final bool stayAwake;
  final bool demoMode;
  final bool forceDarkMode;
  final double fontScale;
  final bool gpuProfiling;
  final bool strictMode;
  final double animationScale;
  final bool isAdbGranted;
  final String? successMessage;
  final String? errorMessage;

  ToolsState copyWith({
    bool? showLayoutBounds,
    bool? showTaps,
    bool? showPointerLocation,
    bool? stayAwake,
    bool? demoMode,
    bool? forceDarkMode,
    double? fontScale,
    bool? gpuProfiling,
    bool? strictMode,
    double? animationScale,
    bool? isAdbGranted,
    String? successMessage,
    String? errorMessage,
  }) {
    return ToolsState(
      showLayoutBounds: showLayoutBounds ?? this.showLayoutBounds,
      showTaps: showTaps ?? this.showTaps,
      showPointerLocation: showPointerLocation ?? this.showPointerLocation,
      stayAwake: stayAwake ?? this.stayAwake,
      demoMode: demoMode ?? this.demoMode,
      forceDarkMode: forceDarkMode ?? this.forceDarkMode,
      fontScale: fontScale ?? this.fontScale,
      gpuProfiling: gpuProfiling ?? this.gpuProfiling,
      strictMode: strictMode ?? this.strictMode,
      animationScale: animationScale ?? this.animationScale,
      isAdbGranted: isAdbGranted ?? this.isAdbGranted,
      successMessage: successMessage,
      errorMessage: errorMessage,
    );
  }
}
