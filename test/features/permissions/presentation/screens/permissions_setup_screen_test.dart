import 'package:devkit/features/permissions/application/permissions_cubit.dart';
import 'package:devkit/features/permissions/presentation/screens/permissions_setup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget createWidgetUnderTest(PermissionsCubit cubit) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<PermissionsCubit>.value(
          value: cubit,
          child: const PermissionsSetupScreen(),
        ),
      ),
    );
  }

  group('PermissionsSetupScreen Widget Tests', () {
    late PermissionsCubit cubit;

    setUp(() async {
      cubit = PermissionsCubit();
      await cubit.checkInitialPermissions();
    });

    tearDown(() async {
      await cubit.close();
    });

    testWidgets('renders step 1 title and permission cards', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(cubit));
      await tester.pumpAndSettle();

      expect(find.text('Setup Permissions'), findsOneWidget);
      expect(find.text('STEP 1 OF 2 • BASIC ACCESS'), findsOneWidget);
      expect(find.text('Nearby Wi-Fi & Devices'), findsOneWidget);
      expect(find.text('Notifications'), findsOneWidget);
    });

    testWidgets('navigates to step 2 when Continue button is tapped', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest(cubit));
      await tester.pumpAndSettle();

      final continueBtn = find.text('Continue to Step 2');
      expect(continueBtn, findsOneWidget);

      await tester.tap(continueBtn);
      await tester.pumpAndSettle();

      expect(cubit.state.currentStep, equals(2));
      expect(find.text('Enable Direct Mode'), findsOneWidget);
    });
  });
}
