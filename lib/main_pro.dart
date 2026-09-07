import 'package:devkit/core/flavors/flavor_config.dart';
import 'package:devkit/features/core/presentation/screens/my_app.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig.initialize(
    flavor: .pro,
    values: const FlavorValues(titleApp: 'Devkit Pro'),
  );
  runApp(const MyApp());
}
