import 'package:devkit/core/services/device_info_service.dart';
import 'package:devkit/core/services/system_settings_service.dart';

abstract class HomeLocalDataSource {
  Future<DeviceInfoData> getDeviceInfo();
  Future<SystemSettingsData> getSystemSettings();
  Future<bool> setDevOptions({required bool enabled});
  Future<bool> setUsbDebugging({required bool enabled});
  Future<bool> setWirelessDebugging({required bool enabled});
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  const new();

  @override
  Future<DeviceInfoData> getDeviceInfo() {
    return DeviceInfoService.getDeviceInfo();
  }

  @override
  Future<SystemSettingsData> getSystemSettings() {
    return SystemSettingsService.getSystemSettings();
  }

  @override
  Future<bool> setDevOptions({required bool enabled}) {
    return SystemSettingsService.setDevOptions(enabled: enabled);
  }

  @override
  Future<bool> setUsbDebugging({required bool enabled}) {
    return SystemSettingsService.setUsbDebugging(enabled: enabled);
  }

  @override
  Future<bool> setWirelessDebugging({required bool enabled}) {
    return SystemSettingsService.setWirelessDebugging(enabled: enabled);
  }
}
