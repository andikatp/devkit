import 'package:devkit/core/flavors/flavor_config.dart';
import 'package:devkit/features/core/presentation/screens/my_app.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig.initialize();
  runApp(const MyApp());
}
