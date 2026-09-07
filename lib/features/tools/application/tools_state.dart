class ToolsState {
  const new({
    this.showLayoutBounds = false,
    this.showTaps = true,
    this.showPointerLocation = false,
    this.gpuProfiling = false,
    this.strictMode = false,
    this.animationScale = 1.0,
  });

  final bool showLayoutBounds;
  final bool showTaps;
  final bool showPointerLocation;
  final bool gpuProfiling;
  final bool strictMode;
  final double animationScale;

  ToolsState copyWith({
    bool? showLayoutBounds,
    bool? showTaps,
    bool? showPointerLocation,
    bool? gpuProfiling,
    bool? strictMode,
    double? animationScale,
  }) {
    return ToolsState(
      showLayoutBounds: showLayoutBounds ?? this.showLayoutBounds,
      showTaps: showTaps ?? this.showTaps,
      showPointerLocation: showPointerLocation ?? this.showPointerLocation,
      gpuProfiling: gpuProfiling ?? this.gpuProfiling,
      strictMode: strictMode ?? this.strictMode,
      animationScale: animationScale ?? this.animationScale,
    );
  }
}
