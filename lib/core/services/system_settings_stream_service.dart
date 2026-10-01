import 'dart:io';

import 'package:devkit/core/services/system_settings_service.dart';
import 'package:flutter/services.dart';

/// Data class for tools-specific settings pushed from the native stream.
class ToolsSettingsData {
  const new({
    required this.showTaps,
    required this.showPointerLocation,
    required this.stayAwake,
    required this.animationScale,
    required this.demoMode,
    required this.forceDarkMode,
    required this.fontScale,
  });

  final bool showTaps;
  final bool showPointerLocation;
  final bool stayAwake;
  final double animationScale;
  final bool demoMode;
  final bool forceDarkMode;
  final double fontScale;
}

/// Wraps the native Android EventChannel that uses ContentObserver to push
/// setting changes in real time. Provides typed streams for both dashboard
/// and tools features.
class SystemSettingsStreamService {
  new() {
    if (Platform.isAndroid) {
      _rawStream = _eventChannel
          .receiveBroadcastStream()
          .map((event) => event as Map<Object?, Object?>)
          .asBroadcastStream();
    }
  }

  static const EventChannel _eventChannel = EventChannel(
    'com.andikatp.devkit/settings_stream',
  );

  Stream<Map<Object?, Object?>>? _rawStream;

  /// Stream of dashboard-related settings (dev options, USB/wireless
  /// debugging, ADB port). Emits whenever any watched setting changes.
  Stream<SystemSettingsData> get dashboardSettingsStream {
    if (_rawStream == null) return const Stream.empty();
    return _rawStream!.map(_parseDashboardSettings);
  }

  /// Stream of tools-related settings (show taps, pointer, stay awake,
  /// animation scale, demo mode, dark mode, font scale).
  Stream<ToolsSettingsData> get toolsSettingsStream {
    if (_rawStream == null) return const Stream.empty();
    return _rawStream!.map(_parseToolsSettings);
  }

  SystemSettingsData _parseDashboardSettings(Map<Object?, Object?> map) {
    return SystemSettingsData(
      isDevOptionsOn: (map['isDevOptionsOn'] as bool?) ?? false,
      isUsbDebuggingOn: (map['isUsbDebuggingOn'] as bool?) ?? false,
      isWirelessDebuggingOn: (map['isWirelessDebuggingOn'] as bool?) ?? false,
      adbPort: (map['adbPort'] as int?) ?? 5555,
      pairingPort: (map['pairingPort'] as int?) ?? 0,
    );
  }

  ToolsSettingsData _parseToolsSettings(Map<Object?, Object?> map) {
    return ToolsSettingsData(
      showTaps: (map['showTaps'] as bool?) ?? false,
      showPointerLocation: (map['showPointerLocation'] as bool?) ?? false,
      stayAwake: (map['stayAwake'] as bool?) ?? false,
      animationScale: (map['animationScale'] as double?) ?? 1.0,
      demoMode: (map['demoMode'] as bool?) ?? false,
      forceDarkMode: (map['forceDarkMode'] as bool?) ?? false,
      fontScale: (map['fontScale'] as double?) ?? 1.0,
    );
  }
}
