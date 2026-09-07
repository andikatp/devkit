import 'package:devkit/core/services/device_info_service.dart';

abstract class HomeRepository {
  Future<DeviceInfoData> getDeviceInfo();
}
