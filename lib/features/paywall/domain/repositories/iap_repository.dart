import 'package:devkit/core/utils/safe_call.dart';
import 'package:devkit/features/paywall/domain/entities/iap_product.dart';

abstract class IapRepository {
  Future<Result<bool>> isAvailable();

  Future<Result<List<IapProduct>>> getProducts({
    required Set<String> productIds,
  });

  Future<Result<bool>> buyProduct({required IapProduct product});

  Future<Result<bool>> restorePurchases();

  Future<Result<bool>> isProUnlocked();

  Stream<bool> get proStatusStream;
}
