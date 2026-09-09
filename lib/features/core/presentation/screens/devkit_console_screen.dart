import 'dart:async';

import 'package:devkit/core/di/injection_container.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:devkit/features/core/application/console_navigation_cubit.dart';
import 'package:devkit/features/core/presentation/widgets/cyber_grid_background.dart';
import 'package:devkit/features/core/presentation/widgets/navbar/bottom_navigation.dart';
import 'package:devkit/features/home/application/devkit_dashboard_cubit.dart';
import 'package:devkit/features/home/presentation/screens/devkit_dashboard_view.dart';
import 'package:devkit/features/logcat/application/logcat_cubit.dart';
import 'package:devkit/features/logcat/presentation/screens/logcat_screen.dart';
import 'package:devkit/features/tools/application/tools_cubit.dart';
import 'package:devkit/features/tools/presentation/screens/tools_screen.dart';
import 'package:devkit/features/tools/presentation/widgets/pro_paywall_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DevKitConsoleScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<DevKitConsoleScreen> createState() => _DevKitConsoleScreenState();
}

class _DevKitConsoleScreenState extends State<DevKitConsoleScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _handleTabSelect(BuildContext context, int index) async {
    final navCubit = context.read<ConsoleNavigationCubit>();
    if (index == 2 && !navCubit.state.isPro) {
      final unlocked = await ProPaywallSheet.show<bool>(context);
      if (unlocked == true && context.mounted) {
        navCubit.unlockPro();
      } else {
        return;
      }
    }
    navCubit.selectTab(index: index);
    if (_pageController.hasClients) {
      await _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _onOpenPaywallSheet(BuildContext context) {
    unawaited(ProPaywallSheet.show<bool>(context));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ConsoleNavigationCubit>()),
        BlocProvider(create: (_) => sl<DevKitDashboardCubit>()),
        BlocProvider(create: (_) => sl<LogcatCubit>()),
        BlocProvider(create: (_) => sl<ToolsCubit>()),
      ],
      child: Builder(
        builder: (context) {
          final navState = context.watch<ConsoleNavigationCubit>().state;

          return Scaffold(
            backgroundColor: AppColors.cyberBlack,
            body: CyberGridBackground(
              child: SafeArea(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
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
