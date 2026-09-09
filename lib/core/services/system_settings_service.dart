import 'dart:io';

import 'package:devkit/core/utils/safe_call.dart';
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

  static Future<Result<SystemSettingsData>> getSystemSettings() {
    if (!Platform.isAndroid) {
      return Future.value(const Result.success(SystemSettingsData.fallback));
    }
    return safeCall(() async {
      final res =
          await _channel.invokeMapMethod<String, dynamic>('getSystemSettings');
      if (res == null) return SystemSettingsData.fallback;

      return SystemSettingsData(
        isDevOptionsOn: (res['isDevOptionsOn'] as bool?) ?? false,
        isUsbDebuggingOn: (res['isUsbDebuggingOn'] as bool?) ?? false,
        isWirelessDebuggingOn: (res['isWirelessDebuggingOn'] as bool?) ?? false,
        adbPort: (res['adbPort'] as int?) ?? 5555,
      );
    });
  }

  static Future<Result<bool>> _invokeBoolSetting(
    String method,
    Map<String, dynamic> args,
  ) {
    if (!Platform.isAndroid) {
      return Future.value(const Result.success(false));
    }
    return safeCall(() async {
      final res = await _channel.invokeMethod<bool>(method, args);
      return res ?? false;
    });
  }

  static Future<Result<Map<String, dynamic>>> getToolsStateMap() {
    if (!Platform.isAndroid) {
      return Future.value(const Result.success(<String, dynamic>{}));
    }
    return safeCall(() async {
      final res =
          await _channel.invokeMapMethod<String, dynamic>('getToolsState');
      return res ?? <String, dynamic>{};
    });
  }

  static Future<Result<bool>> setDevOptions({required bool enabled}) =>
      _invokeBoolSetting('setDevOptions', {'enabled': enabled});

  static Future<Result<bool>> setUsbDebugging({required bool enabled}) =>
      _invokeBoolSetting('setUsbDebugging', {'enabled': enabled});

  static Future<Result<bool>> setWirelessDebugging({required bool enabled}) =>
      _invokeBoolSetting('setWirelessDebugging', {'enabled': enabled});

  static Future<Result<bool>> setLayoutBounds({required bool enabled}) =>
      _invokeBoolSetting('setLayoutBounds', {'enabled': enabled});

  static Future<Result<bool>> setShowTaps({required bool enabled}) =>
      _invokeBoolSetting('setShowTaps', {'enabled': enabled});

  static Future<Result<bool>> setPointerLocation({required bool enabled}) =>
      _invokeBoolSetting('setPointerLocation', {'enabled': enabled});

  static Future<Result<bool>> setStayAwake({required bool enabled}) =>
      _invokeBoolSetting('setStayAwake', {'enabled': enabled});

  static Future<Result<bool>> setAnimationScale({required double scale}) =>
      _invokeBoolSetting('setAnimationScale', {'scale': scale});

  static Future<Result<bool>> setDemoMode({required bool enabled}) =>
      _invokeBoolSetting('setDemoMode', {'enabled': enabled});

  static Future<Result<bool>> setForceDarkMode({required bool enabled}) =>
      _invokeBoolSetting('setForceDarkMode', {'enabled': enabled});

  static Future<Result<bool>> setFontScale({required double scale}) =>
      _invokeBoolSetting('setFontScale', {'scale': scale});

  static Future<Result<bool>> setGpuProfiling({required bool enabled}) =>
      _invokeBoolSetting('setGpuProfiling', {'enabled': enabled});

  static Future<Result<bool>> setStrictMode({required bool enabled}) =>
      _invokeBoolSetting('setStrictMode', {'enabled': enabled});
}
