import 'package:devkit/core/theme/app_theme.dart';
import 'package:devkit/features/core/presentation/screens/devkit_console_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DevKit - Android Developer Dashboard',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkCyberTheme,
      home: const DevKitConsoleScreen(),
    );
  }
}
