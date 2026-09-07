import 'package:devkit/core/di/injection_container.dart';
import 'package:devkit/core/flavors/flavor_config.dart';
import 'package:devkit/features/core/presentation/screens/my_app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig.initialize();
  await initServiceLocator();
  runApp(const MyApp());
}
