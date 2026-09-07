class ConsoleNavigationState {
  const new({
    this.currentNavIndex = 0,
    this.isPro = false,
  });

  final int currentNavIndex;
  final bool isPro;

  ConsoleNavigationState copyWith({
    int? currentNavIndex,
    bool? isPro,
  }) {
    return ConsoleNavigationState(
      currentNavIndex: currentNavIndex ?? this.currentNavIndex,
      isPro: isPro ?? this.isPro,
    );
  }
}
