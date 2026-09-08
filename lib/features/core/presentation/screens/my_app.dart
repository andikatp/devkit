import 'package:devkit/core/services/secure_storage_service.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:devkit/features/core/presentation/screens/devkit_console_screen.dart';
import 'package:devkit/features/permissions/presentation/screens/permissions_setup_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const new({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<bool> _hasSeenFuture;

  @override
  void initState() {
    super.initState();
    _hasSeenFuture = SecureStorageService.hasSeenPermissionsSetup();
  }

  void _onPermissionsCompleted() {
    setState(() {
      _hasSeenFuture = Future.value(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DevKit - Android Developer Dashboard',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkCyberTheme,
      home: FutureBuilder<bool>(
        future: _hasSeenFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              backgroundColor: AppColors.cyberBlack,
              body: Center(
                child: CircularProgressIndicator(color: AppColors.cyanBright),
              ),
            );
          }

          final hasSeen = snapshot.data ?? false;
          if (!hasSeen) {
            return PermissionsSetupPage(onCompleted: _onPermissionsCompleted);
          }

          return const DevKitConsoleScreen();
        },
      ),
    );
  }
}
