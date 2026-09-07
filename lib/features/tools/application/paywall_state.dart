class PaywallState {
  const new({
    this.selectedTier = 1,
    this.customAmount = '10',
  });

  final int selectedTier;
  final String customAmount;

  String get formattedSelectedPrice {
    if (selectedTier == 0) return r'$1.00';
    if (selectedTier == 1) return r'$5.00';
    final val = customAmount.trim();
    if (val.isEmpty) return r'$10.00';
    final parsed = double.tryParse(val);
    if (parsed == null || parsed <= 0) return r'$10.00';
    return '\$${parsed.toStringAsFixed(2)}';
  }

  PaywallState copyWith({
    int? selectedTier,
    String? customAmount,
  }) {
    return PaywallState(
      selectedTier: selectedTier ?? this.selectedTier,
      customAmount: customAmount ?? this.customAmount,
    );
  }
}
