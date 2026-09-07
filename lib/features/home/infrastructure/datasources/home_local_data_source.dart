import 'package:devkit/core/services/device_info_service.dart';

abstract class HomeLocalDataSource {
  Future<DeviceInfoData> getDeviceInfo();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  const new();

  @override
  Future<DeviceInfoData> getDeviceInfo() {
    return DeviceInfoService.getDeviceInfo();
  }
}
