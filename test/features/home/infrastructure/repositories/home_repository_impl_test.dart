import 'package:devkit/core/services/device_info_service.dart';
import 'package:devkit/core/services/system_settings_service.dart';
import 'package:devkit/core/utils/safe_call.dart';
import 'package:devkit/features/home/infrastructure/datasources/home_local_data_source.dart';
import 'package:devkit/features/home/infrastructure/repositories/home_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

class MockHomeLocalDataSource implements HomeLocalDataSource {
  @override
  Future<Result<DeviceInfoData>> getDeviceInfo() async {
    return const Result<DeviceInfoData>.success(
      DeviceInfoData(
        brand: 'Google',
        model: 'Pixel 8',
        sdkVersion: 34,
        ipAddress: '10.0.0.2',
      ),
    );
  }

  @override
  Future<Result<SystemSettingsData>> getSystemSettings() async {
    return const Result<SystemSettingsData>.success(
      SystemSettingsData.fallback,
    );
  }

  @override
  Future<Result<bool>> setDevOptions({required bool enabled}) async =>
      Result<bool>.success(enabled);

  @override
  Future<Result<bool>> setUsbDebugging({required bool enabled}) async =>
      Result<bool>.success(enabled);

  @override
  Future<Result<bool>> setWirelessDebugging({required bool enabled}) async =>
      Result<bool>.success(enabled);
}

void main() {
  group('HomeRepositoryImpl', () {
    late MockHomeLocalDataSource mockDataSource;
    late HomeRepositoryImpl repository;

    setUp(() {
      mockDataSource = MockHomeLocalDataSource();
      repository = HomeRepositoryImpl(localDataSource: mockDataSource);
    });

    test('getDeviceInfo returns data wrapped in Result.success', () async {
      final result = await repository.getDeviceInfo();
      expect(result.isSuccess, isTrue);
      final info = result.data!;
      expect(info.brand, equals('Google'));
      expect(info.model, equals('Pixel 8'));
      expect(info.sdkVersion, equals(34));
      expect(info.ipAddress, equals('10.0.0.2'));
    });

    test('getSystemSettings returns settings wrapped in Result.success',
        () async {
      final result = await repository.getSystemSettings();
      expect(result.isSuccess, isTrue);
      final settings = result.data!;
      expect(settings.isDevOptionsOn, isTrue);
      expect(settings.isUsbDebuggingOn, isFalse);
      expect(settings.isWirelessDebuggingOn, isTrue);
      expect(settings.adbPort, equals(5555));
    });

    test('setDevOptions forwards call and returns Result.success', () async {
      final result = await repository.setDevOptions(enabled: true);
      expect(result.isSuccess, isTrue);
      expect(result.data, isTrue);
    });

    test('setUsbDebugging forwards call and returns Result.success', () async {
      final result = await repository.setUsbDebugging(enabled: false);
      expect(result.isSuccess, isTrue);
      expect(result.data, isFalse);
    });

    test('setWirelessDebugging forwards call and returns Result.success',
        () async {
      final result = await repository.setWirelessDebugging(enabled: true);
      expect(result.isSuccess, isTrue);
      expect(result.data, isTrue);
    });
  });
}
