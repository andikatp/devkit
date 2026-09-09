import 'dart:io';

import 'package:flutter/services.dart';

class SystemSettingsData {
  const new({
    required this.isDevOptionsOn,
    required this.isUsbDebuggingOn,
    required this.isWirelessDebuggingOn,
    required this.adbPort,
  });

  final bool isDevOptionsOn;
  final bool isUsbDebuggingOn;
  final bool isWirelessDebuggingOn;
  final int adbPort;

  static const SystemSettingsData fallback = SystemSettingsData(
    isDevOptionsOn: true,
    isUsbDebuggingOn: false,
    isWirelessDebuggingOn: true,
    adbPort: 5555,
  );
}

abstract final class SystemSettingsService {
  static const MethodChannel _channel =
      MethodChannel('com.andikatp.devkit/settings');

  static Future<SystemSettingsData> getSystemSettings() async {
    if (!Platform.isAndroid) return SystemSettingsData.fallback;
    try {
      final res =
          await _channel.invokeMapMethod<String, dynamic>('getSystemSettings');
      if (res == null) return SystemSettingsData.fallback;

      return SystemSettingsData(
        isDevOptionsOn: (res['isDevOptionsOn'] as bool?) ?? false,
        isUsbDebuggingOn: (res['isUsbDebuggingOn'] as bool?) ?? false,
        isWirelessDebuggingOn: (res['isWirelessDebuggingOn'] as bool?) ?? false,
        adbPort: (res['adbPort'] as int?) ?? 5555,
      );
    } on Exception catch (_) {
      return SystemSettingsData.fallback;
    }
  }

  static Future<bool> setDevOptions({required bool enabled}) async {
    if (!Platform.isAndroid) return false;
    try {
      final res = await _channel
          .invokeMethod<bool>('setDevOptions', {'enabled': enabled});
      return res ?? false;
    } on Exception catch (_) {
      return false;
    }
  }

  static Future<bool> setUsbDebugging({required bool enabled}) async {
    if (!Platform.isAndroid) return false;
    try {
      final res = await _channel
          .invokeMethod<bool>('setUsbDebugging', {'enabled': enabled});
      return res ?? false;
    } on Exception catch (_) {
      return false;
    }
  }

  static Future<bool> setWirelessDebugging({required bool enabled}) async {
    if (!Platform.isAndroid) return false;
    try {
      final res = await _channel
          .invokeMethod<bool>('setWirelessDebugging', {'enabled': enabled});
      return res ?? false;
    } on Exception catch (_) {
      return false;
    }
  }
}
