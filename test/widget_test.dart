import 'package:devkit/core/di/injection_container.dart';
import 'package:devkit/features/core/presentation/screens/devkit_console_screen.dart';
import 'package:devkit/features/core/presentation/screens/my_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MyApp renders DevKitConsoleScreen', (tester) async {
    await initServiceLocator();
    await tester.pumpWidget(const MyApp());
    expect(find.byType(DevKitConsoleScreen), findsOneWidget);
    expect(find.text('HOME'), findsOneWidget);
    expect(find.text('LOGCAT'), findsWidgets);
    expect(find.text('TOOLS'), findsOneWidget);
  });
}
