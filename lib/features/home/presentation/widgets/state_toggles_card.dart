import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:devkit/features/home/application/devkit_dashboard_cubit.dart';
import 'package:devkit/features/home/domain/entities/console_state_entity.dart';
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
              _buildToggleRow(
                context,
                title: 'DEVELOPER OPTIONS',
                icon: Icons.code,
                value: state.isDevOptionsOn,
                onChanged: (val) => cubit.toggleDevOptions(value: val),
              ),
              const Divider(color: AppColors.cyberBorder, height: 24),
              _buildToggleRow(
                context,
                title: 'USB DEBUGGING',
                icon: Icons.usb,
                value: state.isUsbDebuggingOn,
                onChanged: (val) => cubit.toggleUsbDebugging(value: val),
              ),
              const Divider(color: AppColors.cyberBorder, height: 24),
              _buildToggleRow(
                context,
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

  Widget _buildToggleRow(
    BuildContext context, {
    required String title,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      spacing: 8,
      children: [
        Expanded(
          child: Row(
            spacing: 10,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: value ? AppColors.cyanBright : AppColors.cyberRed,
                  boxShadow: [
                    BoxShadow(
                      color: value ? AppColors.cyanBright : AppColors.cyberRed,
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
              Icon(icon, color: AppColors.cyberMuted, size: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      title,
                      style: context.labelSmall.copyWith(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: .bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      value ? 'On' : 'Off',
                      style: context.labelSmall.copyWith(
                        color: value
                            ? AppColors.cyanBright
                            : AppColors.cyberRed,
                        fontSize: 11,
                        fontWeight: .w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Switch.adaptive(
          value: value,
          onChanged: onChanged,
          activeTrackColor: AppColors.deepBlue,
          inactiveThumbColor: AppColors.cyberDim,
          inactiveTrackColor: AppColors.cyberCardAlt,
        ),
      ],
    );
  }
}
