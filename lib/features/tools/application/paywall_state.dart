import 'package:devkit/features/paywall/domain/entities/iap_product.dart';

class PaywallState {
  const new({
    this.selectedTier = 1,
    this.customAmount = '10',
    this.isLoading = false,
    this.isPurchasing = false,
    this.isProUnlocked = false,
    this.products = const [
      IapProduct.coffeeFallback,
      IapProduct.licenseFallback,
      IapProduct.supporterFallback,
    ],
    this.successMessage,
    this.errorMessage,
  });

  final int selectedTier;
  final String customAmount;
  final bool isLoading;
  final bool isPurchasing;
  final bool isProUnlocked;
  final List<IapProduct> products;
  final String? successMessage;
  final String? errorMessage;

  IapProduct get selectedProduct {
    if (selectedTier < products.length) {
      return products[selectedTier];
    }
    return products.last;
  }

  String get formattedSelectedPrice {
    if (selectedTier < products.length && selectedTier != 2) {
      return products[selectedTier].price;
    }
    final val = customAmount.trim();
    if (val.isEmpty) return r'$10.00';
    final parsed = double.tryParse(val);
    if (parsed == null || parsed <= 0) return r'$10.00';
    return '\$${parsed.toStringAsFixed(2)}';
  }

  PaywallState copyWith({
    int? selectedTier,
    String? customAmount,
    bool? isLoading,
    bool? isPurchasing,
    bool? isProUnlocked,
    List<IapProduct>? products,
    String? successMessage,
    String? errorMessage,
  }) {
    return PaywallState(
      selectedTier: selectedTier ?? this.selectedTier,
      customAmount: customAmount ?? this.customAmount,
      isLoading: isLoading ?? this.isLoading,
      isPurchasing: isPurchasing ?? this.isPurchasing,
      isProUnlocked: isProUnlocked ?? this.isProUnlocked,
      products: products ?? this.products,
      successMessage: successMessage,
      errorMessage: errorMessage,
    );
  }
}
