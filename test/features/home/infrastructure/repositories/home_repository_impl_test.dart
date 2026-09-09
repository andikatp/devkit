import 'package:devkit/core/services/device_info_service.dart';
import 'package:devkit/core/services/system_settings_service.dart';
import 'package:devkit/features/home/infrastructure/datasources/home_local_data_source.dart';
import 'package:devkit/features/home/infrastructure/repositories/home_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

class MockHomeLocalDataSource implements HomeLocalDataSource {
  @override
  Future<DeviceInfoData> getDeviceInfo() async {
    return const .new(
      brand: 'Google',
      model: 'Pixel 8',
      sdkVersion: 34,
      ipAddress: '10.0.0.2',
    );
  }

  @override
  Future<SystemSettingsData> getSystemSettings() async {
    return SystemSettingsData.fallback;
  }

  @override
  Future<bool> setDevOptions({required bool enabled}) async => enabled;

  @override
  Future<bool> setUsbDebugging({required bool enabled}) async => enabled;

  @override
  Future<bool> setWirelessDebugging({required bool enabled}) async => enabled;
}

void main() {
  group('HomeRepositoryImpl', () {
    late MockHomeLocalDataSource mockDataSource;
    late HomeRepositoryImpl repository;

    setUp(() {
      mockDataSource = MockHomeLocalDataSource();
      repository = HomeRepositoryImpl(localDataSource: mockDataSource);
    });

    test('getDeviceInfo returns data from local data source', () async {
      final info = await repository.getDeviceInfo();
      expect(info.brand, equals('Google'));
      expect(info.model, equals('Pixel 8'));
      expect(info.sdkVersion, equals(34));
      expect(info.ipAddress, equals('10.0.0.2'));
    });

    test('getSystemSettings returns settings from local data source',
        () async {
      final settings = await repository.getSystemSettings();
      expect(settings.isDevOptionsOn, isTrue);
      expect(settings.isUsbDebuggingOn, isFalse);
      expect(settings.isWirelessDebuggingOn, isTrue);
      expect(settings.adbPort, equals(5555));
    });

    test('setDevOptions forwards call to local data source', () async {
      final result = await repository.setDevOptions(enabled: true);
      expect(result, isTrue);
    });

    test('setUsbDebugging forwards call to local data source', () async {
      final result = await repository.setUsbDebugging(enabled: false);
      expect(result, isFalse);
    });

    test('setWirelessDebugging forwards call to local data source', () async {
      final result = await repository.setWirelessDebugging(enabled: true);
      expect(result, isTrue);
    });
  });
}
