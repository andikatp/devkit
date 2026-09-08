import 'package:devkit/core/constant/app_keys.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract final class SecureStorageService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<bool> hasSeenPermissionsSetup() async {
    try {
      final val = await _storage.read(key: AppKeys.hasSeenPermissionsSetup);
      return val == 'true';
    } on Exception catch (_) {
      return false;
    }
  }

  static Future<void> markPermissionsSetupSeen() async {
    try {
      await _storage.write(
        key: AppKeys.hasSeenPermissionsSetup,
        value: 'true',
      );
    } on Exception catch (_) {}
  }
}
