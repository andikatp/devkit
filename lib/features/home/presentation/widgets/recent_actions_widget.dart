import 'dart:async';

import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:devkit/features/core/application/console_navigation_cubit.dart';
import 'package:devkit/features/home/application/devkit_dashboard_cubit.dart';
import 'package:devkit/features/home/domain/entities/console_state_entity.dart';
import 'package:devkit/features/home/presentation/widgets/ping_status_card_widget.dart';
import 'package:devkit/features/home/presentation/widgets/quick_action_chip_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecentActionsWidget extends StatelessWidget {
  const new({super.key});

  void _onToggleDevMode(BuildContext context) {
    final cubit = context.read<DevKitDashboardCubit>();
    final currentVal = cubit.state.consoleState.isDevOptionsOn;
    unawaited(cubit.toggleDevOptions(value: !currentVal));
  }

  void _onCopyAdbCommand(BuildContext context) {
    final cubit = context.read<DevKitDashboardCubit>();
    final cmd = cubit.state.consoleState.adbConnectCommand;
    unawaited(Clipboard.setData(ClipboardData(text: cmd)));

    _showSnackBar(context, message: 'Copied: "$cmd" to clipboard');
  }

  void _onOpenLogcat(BuildContext context) {
    context.read<ConsoleNavigationCubit>().selectTab(index: 1);
  }

  void _onTogglePing(BuildContext context) {
    context.read<DevKitDashboardCubit>().togglePing();
  }

  void _showSnackBar(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: context.bodySmall.copyWith(
            color: Colors.white,
            fontWeight: .bold,
            fontSize: 12,
          ),
        ),
        backgroundColor: AppColors.cyberDark,
        behavior: .fixed,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final consoleState = context
        .watch<DevKitDashboardCubit>()
        .state
        .consoleState;

    return Column(
      crossAxisAlignment: .start,
      spacing: 16,
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  '01 ',
                  style: context.labelMedium.copyWith(
                    color: AppColors.cyanBright,
                    fontWeight: .bold,
                    fontSize: 12,
                  ),
                ),
                Text(
                  'QUICK ACTIONS',
                  style: context.labelMedium.copyWith(
                    color: AppColors.cyberMuted,
                    fontWeight: .bold,
                    fontSize: 12,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            Container(
              padding: const .symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.cyberCardDeep,
                borderRadius: .circular(4),
                border: .all(color: AppColors.cyberBorder),
              ),
              child: Text(
                'SHORTCUTS',
                style: context.labelSmall.copyWith(
                  color: AppColors.cyanBright,
                  fontSize: 10,
                  fontWeight: .bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
        Row(
          spacing: 6,
          children: [
            Expanded(
              child: QuickActionChipWidget(
                icon: const Icon(
                  Icons.toggle_on,
                  color: AppColors.cyanBright,
                  size: 16,
                ),
                label: 'DEV MODE',
                onTap: () => _onToggleDevMode(context),
              ),
            ),
            Expanded(
              child: QuickActionChipWidget(
                icon: Text(
                  '>_',
                  style: context.labelSmall.copyWith(
                    color: AppColors.primaryBlue,
                    fontWeight: .bold,
                    fontSize: 12,
                  ),
                ),
                label: 'ADB CONNECT',
                onTap: () => _onCopyAdbCommand(context),
              ),
            ),
            Expanded(
              child: QuickActionChipWidget(
                icon: const Icon(
                  Icons.list_alt,
                  color: AppColors.cyberEmerald,
                  size: 16,
                ),
                label: 'LOGCAT',
                onTap: () => _onOpenLogcat(context),
              ),
            ),
            Expanded(
              child: QuickActionChipWidget(
                icon: Text(
                  '⚡',
                  style: context.labelSmall.copyWith(
                    color: consoleState.isPingActive
                        ? AppColors.cyberAmber
                        : AppColors.cyberMuted,
                    fontSize: 12,
                  ),
                ),
                label: 'PING',
                isSelected: consoleState.isPingActive,
                activeColor: AppColors.cyberAmber,
                onTap: () => _onTogglePing(context),
              ),
            ),
          ],
        ),
        if (consoleState.isPingActive) ...[const PingStatusCardWidget()],
      ],
    );
  }
}
