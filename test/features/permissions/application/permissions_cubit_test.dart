import 'package:devkit/features/permissions/application/permissions_cubit.dart';
import 'package:devkit/features/permissions/application/permissions_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PermissionsState', () {
    test('supports default values and copyWith', () {
      const state = PermissionsState();
      expect(state.currentStep, equals(1));
      expect(state.isNearbyWifiGranted, isFalse);
      expect(state.isNotificationGranted, isFalse);
      expect(state.isLocationGranted, isFalse);
      expect(state.isDirectModeGranted, isFalse);
      expect(state.isVerifying, isFalse);

      final updated = state.copyWith(
        currentStep: 2,
        isNearbyWifiGranted: true,
        isNotificationGranted: true,
        isLocationGranted: true,
        isDirectModeGranted: true,
        isVerifying: true,
      );

      expect(updated.currentStep, equals(2));
      expect(updated.isNearbyWifiGranted, isTrue);
      expect(updated.isNotificationGranted, isTrue);
      expect(updated.isLocationGranted, isTrue);
      expect(updated.isDirectModeGranted, isTrue);
      expect(updated.isVerifying, isTrue);
    });
  });

  group('PermissionsCubit', () {
    late PermissionsCubit cubit;

    setUp(() async {
      cubit = PermissionsCubit();
      await cubit.checkInitialPermissions();
    });

    tearDown(() async {
      await cubit.close();
    });

    test('initial state defaults to step 1', () {
      expect(cubit.state.currentStep, equals(1));
    });

    test('setStep updates currentStep in state', () {
      cubit.setStep(2);
      expect(cubit.state.currentStep, equals(2));
    });

    test('requestNearbyWifi updates state', () async {
      await cubit.requestNearbyWifi();
      expect(cubit.state.isNearbyWifiGranted, isTrue);
    });

    test('requestNotification updates state', () async {
      await cubit.requestNotification();
      expect(cubit.state.isNotificationGranted, isTrue);
    });

    test('requestLocation updates state', () async {
      await cubit.requestLocation();
      expect(cubit.state.isLocationGranted, isTrue);
    });

    test('verifyDirectModeGrant updates isVerifying and isDirectModeGranted', () async {
      final verifyFuture = cubit.verifyDirectModeGrant();
      expect(cubit.state.isVerifying, isTrue);
      await verifyFuture;
      expect(cubit.state.isVerifying, isFalse);
      expect(cubit.state.isDirectModeGranted, isTrue);
    });
  });
}
