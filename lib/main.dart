import 'package:devkit/core/di/injection_container.dart';
import 'package:devkit/features/core/presentation/screens/my_app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
  runApp(const MyApp());
}
