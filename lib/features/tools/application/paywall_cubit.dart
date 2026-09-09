import 'dart:async';

import 'package:devkit/features/paywall/domain/repositories/iap_repository.dart';
import 'package:devkit/features/tools/application/paywall_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaywallCubit extends Cubit<PaywallState> {
  new({required this.iapRepository, PaywallState? initialState})
    : super(initialState ?? const .new()) {
    _proStatusSub = iapRepository.proStatusStream.listen((isUnlocked) {
      if (!isClosed) {
        emit(
          state.copyWith(
            isPurchasing: false,
            isProUnlocked: isUnlocked,
            successMessage: isUnlocked
                ? 'DevKit Pro unlocked permanently!'
                : null,
          ),
        );
      }
    });
    unawaited(_initPaywall());
  }

  final IapRepository iapRepository;
  StreamSubscription<bool>? _proStatusSub;

  static const Set<String> defaultProductIds = {
    'devkit_pro_coffee',
    'devkit_pro_license',
    'devkit_pro_supporter',
  };

  Future<void> _initPaywall() async {
    emit(state.copyWith(isLoading: true));
    final isUnlockedResult = await iapRepository.isProUnlocked();
    final isUnlocked = isUnlockedResult.data ?? false;

    final productsResult = await iapRepository.getProducts(
      productIds: defaultProductIds,
    );
    final products = productsResult.data ?? state.products;

    if (isClosed) return;

    emit(
      state.copyWith(
        isLoading: false,
        isProUnlocked: isUnlocked,
        products: products,
      ),
    );
  }

  void selectTier({required int index}) {
    emit(state.copyWith(selectedTier: index));
  }

  void updateCustomAmount({required String amount}) {
    emit(state.copyWith(customAmount: amount));
  }

  Future<void> purchaseSelectedProduct() async {
    if (state.isPurchasing) return;
    emit(state.copyWith(isPurchasing: true));

    final targetProduct = state.selectedProduct;
    final result = await iapRepository.buyProduct(product: targetProduct);

    if (isClosed) return;

    if (result.isFailure || result.data != true) {
      emit(
        state.copyWith(
          isPurchasing: false,
          errorMessage: result.failure?.message ?? 'Purchase failed',
        ),
      );
    }
  }

  Future<void> restorePurchases() async {
    emit(state.copyWith(isLoading: true));
    final result = await iapRepository.restorePurchases();

    if (isClosed) return;

    if (result.isSuccess && result.data == true) {
      emit(
        state.copyWith(
          isLoading: false,
          isProUnlocked: true,
          successMessage: 'Restored DevKit Pro purchases successfully!',
        ),
      );
    } else {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: result.failure?.message ?? 'No past purchases found',
        ),
      );
    }
  }

  @override
  Future<void> close() async {
    await _proStatusSub?.cancel();
    return await super.close();
  }
}
