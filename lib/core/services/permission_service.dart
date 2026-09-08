import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

abstract final class PermissionService {
  static const MethodChannel _channel =
      MethodChannel('com.andikatp.devkit/permissions');

  static Future<bool> isWriteSecureSettingsGranted() async {
    if (!Platform.isAndroid) return true;
    try {
      final isGranted =
          await _channel.invokeMethod<bool>('checkWriteSecureSettings');
      return isGranted ?? false;
    } on Exception catch (_) {
      // Fallback: If channel not attached, return false
      return false;
    }
  }

  static Future<bool> isNearbyWifiGranted() async {
    if (!Platform.isAndroid) return true;
    return await Permission.nearbyWifiDevices.isGranted;
  }

  static Future<bool> requestNearbyWifi() async {
    if (!Platform.isAndroid) return true;
    final status = await Permission.nearbyWifiDevices.request();
    return status.isGranted;
  }

  static Future<bool> isNotificationGranted() async {
    if (!Platform.isAndroid) return true;
    return await Permission.notification.isGranted;
  }

  static Future<bool> requestNotification() async {
    if (!Platform.isAndroid) return true;
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  static Future<bool> isLocationGranted() async {
    if (!Platform.isAndroid) return true;
    return await Permission.locationWhenInUse.isGranted;
  }

  static Future<bool> requestLocation() async {
    if (!Platform.isAndroid) return true;
    final status = await Permission.locationWhenInUse.request();
    return status.isGranted;
  }

  static Future<void> openDeveloperSettings() async {
    if (!Platform.isAndroid) return;
    const intent = AndroidIntent(
      action: 'android.settings.APPLICATION_DEVELOPMENT_SETTINGS',
    );
    try {
      await intent.launch();
    } on Exception catch (_) {
      const fallbackIntent = AndroidIntent(
        action: 'android.settings.SETTINGS',
      );
      await fallbackIntent.launch();
    }
  }
}
