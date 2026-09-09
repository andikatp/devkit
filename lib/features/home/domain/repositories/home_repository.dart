import 'package:devkit/core/services/device_info_service.dart';
import 'package:devkit/core/services/system_settings_service.dart';

abstract class HomeRepository {
  Future<DeviceInfoData> getDeviceInfo();
  Future<SystemSettingsData> getSystemSettings();
  Future<bool> setDevOptions({required bool enabled});
  Future<bool> setUsbDebugging({required bool enabled});
  Future<bool> setWirelessDebugging({required bool enabled});
}
