import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:devkit/features/home/application/devkit_dashboard_cubit.dart';
import 'package:devkit/features/home/domain/entities/console_state_entity.dart';
import 'package:devkit/features/home/presentation/widgets/state_toggles_card/toggle_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glow_container/glow_container.dart';

class StateTogglesCard extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<DevKitDashboardCubit>();
    final state = cubit.state.consoleState;

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
                  '02 ',
                  style: context.labelSmall.copyWith(
                    color: AppColors.cyanBright,
                    fontWeight: .bold,
                    fontSize: 12,
                  ),
                ),
                Text(
                  'STATE',
                  style: context.labelSmall.copyWith(
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
                state.modeText,
                style: context.labelSmall.copyWith(
                  color: state.isAdbGrantMode
                      ? AppColors.cyanBright
                      : AppColors.cyberMuted,
                  fontSize: 10,
                  fontWeight: .bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
        GlowContainer(
          gradientColors: const [
            AppColors.cyanBright,
            AppColors.deepBlue,
            AppColors.primaryBlue,
          ],
          glowRadius: 8,
          rotationDuration: const Duration(seconds: 4),
          containerOptions: const ContainerOptions(
            backgroundColor: AppColors.cyberCard,
            borderRadius: 12,
            borderSide: BorderSide(color: AppColors.cyberBorder, width: 1.5),
            padding: .all(16),
          ),
          child: Column(
            children: [
              ToggleRowWidget(
                title: 'DEVELOPER OPTIONS',
                icon: Icons.code,
                value: state.isDevOptionsOn,
                onChanged: (val) => cubit.toggleDevOptions(value: val),
              ),
              const Divider(color: AppColors.cyberBorder, height: 24),
              ToggleRowWidget(
                title: 'USB DEBUGGING',
                icon: Icons.usb,
                value: state.isUsbDebuggingOn,
                onChanged: (val) => cubit.toggleUsbDebugging(value: val),
              ),
              const Divider(color: AppColors.cyberBorder, height: 24),
              ToggleRowWidget(
                title: 'WIRELESS DEBUGGING',
                icon: Icons.wifi_tethering,
                value: state.isWirelessDebuggingOn,
                onChanged: (val) => cubit.toggleWirelessDebugging(value: val),
              ),
              const Divider(color: AppColors.cyberBorder, height: 24),
              Row(
                children: [
                  Text(
                    '⚡ ',
                    style: context.bodySmall.copyWith(
                      color: AppColors.cyanBright,
                      fontSize: 12,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      state.footnoteText,
                      style: context.bodySmall.copyWith(
                        color: AppColors.cyberMuted,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
