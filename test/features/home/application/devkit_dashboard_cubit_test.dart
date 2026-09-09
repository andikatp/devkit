import 'package:devkit/core/services/device_info_service.dart';
import 'package:devkit/core/services/system_settings_service.dart';
import 'package:devkit/core/utils/safe_call.dart';
import 'package:devkit/features/home/application/devkit_dashboard_cubit.dart';
import 'package:devkit/features/home/application/devkit_dashboard_state.dart';
import 'package:devkit/features/home/domain/entities/console_state_entity.dart';
import 'package:devkit/features/home/domain/repositories/home_repository.dart';
import 'package:flutter_test/flutter_test.dart';

class MockHomeRepository implements HomeRepository {
  bool devOptionsSet = false;
  bool usbDebuggingSet = false;
  bool wirelessDebuggingSet = false;

  @override
  Future<Result<DeviceInfoData>> getDeviceInfo() async {
    return const Result<DeviceInfoData>.success(
      DeviceInfoData(
        brand: 'TestBrand',
        model: 'TestModel',
        sdkVersion: 34,
        ipAddress: '192.168.1.100',
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
  Future<Result<bool>> setDevOptions({required bool enabled}) async {
    devOptionsSet = enabled;
    return const Result<bool>.success(true);
  }

  @override
  Future<Result<bool>> setUsbDebugging({required bool enabled}) async {
    usbDebuggingSet = enabled;
    return const Result<bool>.success(true);
  }

  @override
  Future<Result<bool>> setWirelessDebugging({required bool enabled}) async {
    wirelessDebuggingSet = enabled;
    return const Result<bool>.success(true);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ConsoleStateEntity & Extensions', () {
    test('ConsoleStateEntity copyWith and extension getters work', () {
      const entity = ConsoleStateEntity(
        isDevOptionsOn: true,
        isUsbDebuggingOn: false,
        isWirelessDebuggingOn: true,
        isAdbGrantMode: true,
        deviceIp: '192.168.1.100',
        devicePort: 5555,
        deviceModel: 'TestModel',
        sdkVersion: 34,
      );

      expect(entity.modeText, equals('DIRECT'));
      expect(entity.footnoteText, contains('Flips instantly'));
      expect(
        entity.adbConnectCommand,
        equals('adb connect 192.168.1.100:5555'),
      );

      final updated = entity.copyWith(isAdbGrantMode: false);
      expect(updated.modeText, equals('SHORTCUT'));
      expect(updated.footnoteText, contains('INTENT SHORTCUT'));
    });
  });

  group('DevKitDashboardState', () {
    test('supports copyWith for messages and consoleState', () {
      const state = DevKitDashboardState();
      expect(state.successMessage, isNull);
      expect(state.errorMessage, isNull);

      final updated = state.copyWith(
        successMessage: 'Success',
        errorMessage: 'Error',
      );
      expect(updated.successMessage, equals('Success'));
      expect(updated.errorMessage, equals('Error'));
    });
  });

  group('DevKitDashboardCubit', () {
    late MockHomeRepository mockRepository;
    late DevKitDashboardCubit cubit;

    setUp(() {
      mockRepository = MockHomeRepository();
      cubit = DevKitDashboardCubit(homeRepository: mockRepository);
    });

    tearDown(() async {
      await cubit.close();
    });

    test('initial state loads device info and system settings', () async {
      await Future<void>.delayed(Duration.zero);
      expect(cubit.state.consoleState.deviceModel, equals('TestModel'));
      expect(cubit.state.consoleState.deviceIp, equals('192.168.1.100'));
      expect(cubit.state.consoleState.isDevOptionsOn, isTrue);
      expect(cubit.state.consoleState.isUsbDebuggingOn, isFalse);
      expect(cubit.state.consoleState.isWirelessDebuggingOn, isTrue);
    });

    test('toggleDevOptions calls repository and emits success message',
        () async {
      await Future<void>.delayed(Duration.zero);
      await cubit.toggleDevOptions(value: false);

      expect(cubit.state.consoleState.isDevOptionsOn, isFalse);
      expect(cubit.state.successMessage, contains('DISABLED'));
    });

    test('toggleUsbDebugging calls repository and emits success message',
        () async {
      await Future<void>.delayed(Duration.zero);
      await cubit.toggleUsbDebugging(value: true);

      expect(cubit.state.consoleState.isUsbDebuggingOn, isTrue);
      expect(cubit.state.successMessage, contains('ENABLED'));
    });

    test('toggleWirelessDebugging calls repository and emits message',
        () async {
      await Future<void>.delayed(Duration.zero);
      await cubit.toggleWirelessDebugging(value: false);

      expect(cubit.state.consoleState.isWirelessDebuggingOn, isFalse);
      expect(cubit.state.successMessage, contains('DISABLED'));
    });

    test('toggleAdbGrantMode toggles grant mode', () {
      final initialMode = cubit.state.consoleState.isAdbGrantMode;
      cubit.toggleAdbGrantMode();
      expect(cubit.state.consoleState.isAdbGrantMode, equals(!initialMode));
    });

    test('togglePing toggles isPingActive', () {
      expect(cubit.state.consoleState.isPingActive, isFalse);
      cubit.togglePing();
      expect(cubit.state.consoleState.isPingActive, isTrue);
    });
  });
}
