import 'package:devkit/core/services/device_info_service.dart';
import 'package:devkit/core/services/system_settings_service.dart';
import 'package:devkit/core/utils/safe_call.dart';

abstract class HomeRepository {
  Future<Result<DeviceInfoData>> getDeviceInfo();
  Future<Result<SystemSettingsData>> getSystemSettings();
  Future<Result<bool>> setDevOptions({required bool enabled});
  Future<Result<bool>> setUsbDebugging({required bool enabled});
  Future<Result<bool>> setWirelessDebugging({required bool enabled});
}
