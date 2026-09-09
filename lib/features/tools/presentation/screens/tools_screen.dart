import 'dart:developer';

import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:devkit/features/core/presentation/widgets/header_widget.dart';
import 'package:devkit/features/tools/application/tools_cubit.dart';
import 'package:devkit/features/tools/application/tools_state.dart';
import 'package:devkit/features/tools/presentation/widgets/adb_permission_card.dart';
import 'package:devkit/features/tools/presentation/widgets/animation_scaler_card.dart';
import 'package:devkit/features/tools/presentation/widgets/font_scaler_card.dart';
import 'package:devkit/features/tools/presentation/widgets/pro_suite_banner_card.dart';
import 'package:devkit/features/tools/presentation/widgets/tool_switch_card.dart';
import 'package:devkit/features/tools/presentation/widgets/tools_header_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToolsScreen extends StatelessWidget {
  const new({required this.onOpenPaywallModal, super.key});

  final VoidCallback onOpenPaywallModal;

  void _onStateListener(BuildContext context, ToolsState state) {
    if (state.successMessage != null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            state.successMessage!,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          backgroundColor: AppColors.cyberDark,
          behavior: SnackBarBehavior.fixed,
          duration: const Duration(seconds: 2),
        ),
      );
    } else if (state.errorMessage != null) {
      log(state.errorMessage!);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            state.errorMessage!,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          backgroundColor: AppColors.cyberRed,
          behavior: SnackBarBehavior.fixed,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ToolsCubit>();
    final toolsState = context.watch<ToolsCubit>().state;

    return BlocListener<ToolsCubit, ToolsState>(
      listener: _onStateListener,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            const HeaderWidget(),
            const ToolsHeaderBarWidget(),
            const AdbPermissionCard(),
            ProSuiteBannerCard(onOpenPaywallModal: onOpenPaywallModal),
            Text(
              '1-TAP UNROOTED DEVELOPER UTILITIES',
              style: context.labelSmall.copyWith(
                color: AppColors.cyberMuted,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            ToolSwitchCard(
              title: 'Show Taps & Touches',
              subtitle: 'Display visual circles for touch events',
              icon: Icons.touch_app,
              value: toolsState.showTaps,
              onChanged: (val) => cubit.toggleTaps(value: val),
            ),
            ToolSwitchCard(
              title: 'Pointer Location Overlay',
              subtitle: 'Screen header showing exact touch coordinates',
              icon: Icons.ads_click,
              value: toolsState.showPointerLocation,
              onChanged: (val) => cubit.togglePointerLocation(value: val),
            ),
            ToolSwitchCard(
              title: 'Stay Awake While Plugged In',
              subtitle: 'Keep screen awake when connected to USB or charger',
              icon: Icons.power,
              value: toolsState.stayAwake,
              onChanged: (val) => cubit.toggleStayAwake(value: val),
            ),
            ToolSwitchCard(
              title: 'System Demo Mode',
              subtitle:
                  'Clean status bar (9:40, 100% battery) for app store'
                  ' screenshots',
              icon: Icons.screenshot_monitor,
              value: toolsState.demoMode,
              onChanged: (val) => cubit.toggleDemoMode(value: val),
            ),
            ToolSwitchCard(
              title: 'Force System Dark Theme',
              subtitle: 'Instantly toggle system night mode to test app themes',
              icon: Icons.dark_mode,
              value: toolsState.forceDarkMode,
              onChanged: (val) => cubit.toggleForceDarkMode(value: val),
            ),
            const AnimationScalerCard(),
            const FontScalerCard(),
          ],
        ),
      ),
    );
  }
}
