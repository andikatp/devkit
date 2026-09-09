import 'dart:async';

import 'package:devkit/core/constant/app_keys.dart';
import 'package:devkit/core/errors/exceptions.dart';
import 'package:devkit/core/utils/safe_call.dart';
import 'package:devkit/features/paywall/domain/entities/iap_product.dart';
import 'package:devkit/features/paywall/domain/repositories/iap_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class IapRepositoryImpl implements IapRepository {
  new({InAppPurchase? iapInstance, FlutterSecureStorage? secureStorage})
    : _iap = iapInstance ?? InAppPurchase.instance,
      _storage = secureStorage ?? const FlutterSecureStorage() {
    _initStream();
  }

  final InAppPurchase _iap;
  final FlutterSecureStorage _storage;
  final StreamController<bool> _proStatusController =
      StreamController<bool>.broadcast();
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  void _initStream() {
    _subscription = _iap.purchaseStream.listen(
      _onPurchaseStream,
      onError: (Object error) {
        _proStatusController.add(false);
      },
    );
  }

  Future<void> _onPurchaseStream(List<PurchaseDetails> purchases) async {
    for (final purchase in purchases) {
      if (purchase.status == PurchaseStatus.purchased ||
          purchase.status == PurchaseStatus.restored) {
        await _storage.write(key: AppKeys.proUnlocked, value: 'true');
        _proStatusController.add(true);
        if (purchase.pendingCompletePurchase) {
          await _iap.completePurchase(purchase);
        }
      } else if (purchase.status == PurchaseStatus.error ||
          purchase.status == PurchaseStatus.canceled) {
        if (purchase.pendingCompletePurchase) {
          await _iap.completePurchase(purchase);
        }
        _proStatusController.add(false);
      }
    }
  }

  @override
  Stream<bool> get proStatusStream => _proStatusController.stream;

  @override
  Future<Result<bool>> isAvailable() async {
    return await safeCall(() async {
      final available = await _iap.isAvailable();
      return available;
    });
  }

  @override
  Future<Result<List<IapProduct>>> getProducts({
    required Set<String> productIds,
  }) async {
    return await safeCall(() async {
      final isAvailable = await _iap.isAvailable();
      if (!isAvailable) {
        return const [
          IapProduct.coffeeFallback,
          IapProduct.licenseFallback,
          IapProduct.supporterFallback,
        ];
      }

      final response = await _iap.queryProductDetails(productIds);
      if (response.notFoundIDs.isNotEmpty && response.productDetails.isEmpty) {
        return const [
          IapProduct.coffeeFallback,
          IapProduct.licenseFallback,
          IapProduct.supporterFallback,
        ];
      }

      final mapped = response.productDetails.map((details) {
        return IapProduct(
          id: details.id,
          title: details.title,
          description: details.description,
          price: details.price,
          rawPrice: details.rawPrice,
          currencyCode: details.currencyCode,
        );
      }).toList();

      if (mapped.isEmpty) {
        return const [
          IapProduct.coffeeFallback,
          IapProduct.licenseFallback,
          IapProduct.supporterFallback,
        ];
      }

      return mapped;
    });
  }

  @override
  Future<Result<bool>> buyProduct({required IapProduct product}) async {
    return await safeCall(() async {
      final isAvailable = await _iap.isAvailable();
      if (!isAvailable) {
        if (kDebugMode) {
          await _storage.write(key: AppKeys.proUnlocked, value: 'true');
          _proStatusController.add(true);
          return true;
        }
        throw const CustomPlatformException(
          message: 'Google Play Store unavailable',
        );
      }

      final query = await _iap.queryProductDetails({product.id});
      if (query.productDetails.isEmpty) {
        if (kDebugMode) {
          await _storage.write(key: AppKeys.proUnlocked, value: 'true');
          _proStatusController.add(true);
          return true;
        }
        throw const CustomPlatformException(
          message: 'Product not found in Google Play Store',
        );
      }

      final detail = query.productDetails.first;
      final purchaseParam = PurchaseParam(productDetails: detail);
      final launched = await _iap.buyNonConsumable(
        purchaseParam: purchaseParam,
      );
      return launched;
    });
  }

  @override
  Future<Result<bool>> restorePurchases() async {
    return await safeCall(() async {
      final isAvailable = await _iap.isAvailable();
      if (!isAvailable) {
        final val = await _storage.read(key: AppKeys.proUnlocked);
        return val == 'true';
      }
      await _iap.restorePurchases();
      final val = await _storage.read(key: AppKeys.proUnlocked);
      return val == 'true';
    });
  }

  @override
  Future<Result<bool>> isProUnlocked() async {
    return await safeCall(() async {
      final val = await _storage.read(key: AppKeys.proUnlocked);
      return val == 'true';
    });
  }

  void dispose() {
    unawaited(_subscription?.cancel());
    unawaited(_proStatusController.close());
  }
}
