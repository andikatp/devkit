import 'dart:async';

import 'package:devkit/core/di/injection_container.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:devkit/features/core/application/console_navigation_cubit.dart';
import 'package:devkit/features/core/presentation/widgets/cyber_grid_background.dart';
import 'package:devkit/features/core/presentation/widgets/navbar/bottom_navigation.dart';
import 'package:devkit/features/home/presentation/screens/devkit_dashboard_view.dart';
import 'package:devkit/features/logcat/presentation/screens/logcat_screen.dart';
import 'package:devkit/features/tools/presentation/screens/tools_screen.dart';
import 'package:devkit/features/tools/presentation/widgets/pro_paywall_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DevKitConsoleScreen extends StatelessWidget {
  const new({super.key});

  Future<void> _handleTabSelect(BuildContext context, int index) async {
    final navCubit = context.read<ConsoleNavigationCubit>();
    if (index == 2 && !navCubit.state.isPro) {
      final unlocked = await ProPaywallSheet.show<bool>(context);
      if (unlocked == true && context.mounted) {
        navCubit.unlockPro();
      }
      return;
    }
    navCubit.selectTab(index: index);
  }

  void _onOpenPaywallSheet(BuildContext context) {
    unawaited(ProPaywallSheet.show<bool>(context));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ConsoleNavigationCubit>(),
      child: Builder(
        builder: (context) {
          final navState = context.watch<ConsoleNavigationCubit>().state;

          return Scaffold(
            backgroundColor: AppColors.cyberBlack,
            body: CyberGridBackground(
              child: SafeArea(
                child: IndexedStack(
                  index: navState.currentNavIndex,
                  children: [
                    const DevKitDashboardView(),
                    const LogcatScreen(),
                    ToolsScreen(
                      onOpenPaywallModal: () => _onOpenPaywallSheet(context),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: DevKitBottomNavigationBar(
              currentIndex: navState.currentNavIndex,
              isPro: navState.isPro,
              onTap: (index) => unawaited(_handleTabSelect(context, index)),
            ),
          );
        },
      ),
    );
  }
}
