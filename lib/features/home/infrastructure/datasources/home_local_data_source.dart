import 'package:devkit/core/services/device_info_service.dart';
import 'package:devkit/core/services/system_settings_service.dart';
import 'package:devkit/core/utils/safe_call.dart';

abstract class HomeLocalDataSource {
  Future<Result<DeviceInfoData>> getDeviceInfo();
  Future<Result<SystemSettingsData>> getSystemSettings();
  Future<Result<bool>> setDevOptions({required bool enabled});
  Future<Result<bool>> setUsbDebugging({required bool enabled});
  Future<Result<bool>> setWirelessDebugging({required bool enabled});
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  const new();

  @override
  Future<Result<DeviceInfoData>> getDeviceInfo() {
    return DeviceInfoService.getDeviceInfo();
  }

  @override
  Future<Result<SystemSettingsData>> getSystemSettings() {
    return SystemSettingsService.getSystemSettings();
  }

  @override
  Future<Result<bool>> setDevOptions({required bool enabled}) {
    return SystemSettingsService.setDevOptions(enabled: enabled);
  }

  @override
  Future<Result<bool>> setUsbDebugging({required bool enabled}) {
    return SystemSettingsService.setUsbDebugging(enabled: enabled);
  }

  @override
  Future<Result<bool>> setWirelessDebugging({required bool enabled}) {
    return SystemSettingsService.setWirelessDebugging(enabled: enabled);
  }
}
