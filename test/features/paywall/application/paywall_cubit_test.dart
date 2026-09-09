import 'dart:async';

import 'package:devkit/core/errors/failure.dart';
import 'package:devkit/core/utils/safe_call.dart';
import 'package:devkit/features/paywall/domain/entities/iap_product.dart';
import 'package:devkit/features/paywall/domain/repositories/iap_repository.dart';
import 'package:devkit/features/tools/application/paywall_cubit.dart';
import 'package:devkit/features/tools/application/paywall_state.dart';
import 'package:flutter_test/flutter_test.dart';

class MockIapRepository implements IapRepository {
  bool shouldFail = false;
  bool isUnlocked = false;
  final StreamController<bool> _proStatusController =
      StreamController<bool>.broadcast();

  @override
  Stream<bool> get proStatusStream => _proStatusController.stream;

  @override
  Future<Result<bool>> isAvailable() async => const Result<bool>.success(true);

  @override
  Future<Result<List<IapProduct>>> getProducts({
    required Set<String> productIds,
  }) async {
    if (shouldFail) {
      return const Result<List<IapProduct>>.failure(
        PlatformFailure(message: 'Failed to fetch products'),
      );
    }
    return const Result<List<IapProduct>>.success([
      IapProduct.coffeeFallback,
      IapProduct.licenseFallback,
      IapProduct.supporterFallback,
    ]);
  }

  @override
  Future<Result<bool>> buyProduct({required IapProduct product}) async {
    if (shouldFail) {
      return const Result<bool>.failure(
        PlatformFailure(message: 'Failed to buy product'),
      );
    }
    isUnlocked = true;
    _proStatusController.add(true);
    return const Result<bool>.success(true);
  }

  @override
  Future<Result<bool>> restorePurchases() async {
    if (shouldFail) {
      return const Result<bool>.failure(
        PlatformFailure(message: 'Failed to restore'),
      );
    }
    isUnlocked = true;
    _proStatusController.add(true);
    return const Result<bool>.success(true);
  }

  @override
  Future<Result<bool>> isProUnlocked() async {
    return Result<bool>.success(isUnlocked);
  }
}

void main() {
  group('PaywallState', () {
    test('supports default values and copyWith', () {
      const state = PaywallState();
      expect(state.selectedTier, equals(1));
      expect(state.isProUnlocked, isFalse);
      expect(state.products.length, equals(3));
      expect(state.formattedSelectedPrice, equals(r'$5.00'));

      final updated = state.copyWith(selectedTier: 0);
      expect(updated.selectedTier, equals(0));
      expect(updated.formattedSelectedPrice, equals(r'$1.00'));
    });
  });

  group('PaywallCubit', () {
    late MockIapRepository mockRepository;
    late PaywallCubit cubit;

    setUp(() {
      mockRepository = MockIapRepository();
      cubit = PaywallCubit(iapRepository: mockRepository);
    });

    tearDown(() async {
      await cubit.close();
    });

    test('initialization loads products and pro status', () async {
      await Future<void>.delayed(Duration.zero);
      expect(cubit.state.products.length, equals(3));
      expect(cubit.state.isProUnlocked, isFalse);
    });

    test('selectTier updates selectedTier in state', () {
      cubit.selectTier(index: 0);
      expect(cubit.state.selectedTier, equals(0));
    });

    test('updateCustomAmount updates customAmount in state', () {
      cubit.updateCustomAmount(amount: '25');
      expect(cubit.state.customAmount, equals('25'));
    });

    test('purchaseSelectedProduct sets isProUnlocked on success', () async {
      await cubit.purchaseSelectedProduct();
      await Future<void>.delayed(Duration.zero);
      expect(cubit.state.isProUnlocked, isTrue);
      expect(
        cubit.state.successMessage,
        contains('Pro unlocked'),
      );
    });

    test('purchaseSelectedProduct emits errorMessage on failure', () async {
      mockRepository.shouldFail = true;
      await cubit.purchaseSelectedProduct();
      expect(cubit.state.errorMessage, equals('Failed to buy product'));
    });

    test('restorePurchases sets isProUnlocked on success', () async {
      await cubit.restorePurchases();
      expect(cubit.state.isProUnlocked, isTrue);
      expect(
        cubit.state.successMessage,
        contains('Restored DevKit Pro purchases'),
      );
    });
  });
}
