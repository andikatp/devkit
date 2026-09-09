import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:devkit/core/utils/safe_call.dart';
import 'package:network_info_plus/network_info_plus.dart';

class DeviceInfoData {
  const new({
    required this.brand,
    required this.model,
    required this.sdkVersion,
    required this.ipAddress,
  });

  final String brand;
  final String model;
  final int sdkVersion;
  final String ipAddress;

  static const DeviceInfoData fallback = DeviceInfoData(
    brand: 'Samsung',
    model: 'Galaxy',
    sdkVersion: 34,
    ipAddress: '127.0.0.1',
  );
}

abstract final class DeviceInfoService {
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  static final NetworkInfo _networkInfo = NetworkInfo();

  static Future<Result<DeviceInfoData>> getDeviceInfo() {
    return safeCall(() async {
      var brand = 'Android';
      var model = 'Device';
      var sdkVersion = 34;
      String? ipAddress;

      if (Platform.isAndroid) {
        final androidInfo = await _deviceInfoPlugin.androidInfo;
        brand = androidInfo.brand.isNotEmpty
            ? androidInfo.brand
            : (androidInfo.manufacturer.isNotEmpty
                  ? androidInfo.manufacturer
                  : 'Android');
        model = androidInfo.model.isNotEmpty ? androidInfo.model : 'Device';
        sdkVersion = androidInfo.version.sdkInt;
      }

      ipAddress = await _networkInfo.getWifiIP();
      ipAddress ??= '127.0.0.1';

      return DeviceInfoData(
        brand: brand,
        model: model,
        sdkVersion: sdkVersion,
        ipAddress: ipAddress,
      );
    });
  }
}
