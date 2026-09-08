import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:devkit/features/permissions/application/permissions_cubit.dart';
import 'package:devkit/features/permissions/presentation/widgets/command_copy_box.dart';
import 'package:devkit/features/permissions/presentation/widgets/grant_status_card.dart';
import 'package:devkit/features/permissions/presentation/widgets/multi_device_helper_card.dart';
import 'package:devkit/features/permissions/presentation/widgets/prerequisite_checklist_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DirectModeStep extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<PermissionsCubit>();
    final state = cubit.state;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: .start,
        spacing: 20,
        children: [
          Column(
            crossAxisAlignment: .start,
            spacing: 6,
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: Text(
                      'STEP 2 OF 2 • ADVANCED ACCESS',
                      style: context.labelSmall.copyWith(
                        color: AppColors.cyanBright,
                        fontSize: 11,
                        fontWeight: .bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  Container(
                    padding: const .symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.cyberCardAlt,
                      borderRadius: .circular(4),
                      border: .all(color: AppColors.cyberBorder),
                    ),
                    child: Text(
                      'Optional • Power Users',
                      style: context.labelSmall.copyWith(
                        color: AppColors.cyberMuted,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                'Enable Direct Mode',
                style: context.headlineSmall.copyWith(
                  color: Colors.white,
                  fontWeight: .bold,
                ),
              ),
              Text(
                'Direct Mode allows DevKit to toggle Developer Options, '
                'USB, and Wireless Debugging without leaving the app or '
                'opening system settings.',
                style: context.bodySmall.copyWith(
                  color: AppColors.cyberMuted,
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
            ],
          ),
          const PrerequisiteChecklistCard(),
          Container(
            padding: const .all(16),
            decoration: BoxDecoration(
              color: AppColors.cyberCard,
              borderRadius: .circular(12),
              border: .all(color: AppColors.cyberBorder),
            ),
            child: Column(
              crossAxisAlignment: .start,
              spacing: 12,
              children: [
                Row(
                  spacing: 12,
                  children: [
                    Container(
                      padding: const .all(8),
                      decoration: BoxDecoration(
                        color: AppColors.cyberCardDeep,
                        borderRadius: .circular(8),
                        border: .all(
                          color: AppColors.cyanBright.withValues(alpha: 0.3),
                        ),
                      ),
                      child: const Icon(
                        Icons.terminal,
                        color: AppColors.cyanBright,
                        size: 20,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            'One-Time Setup Command',
                            style: context.labelMedium.copyWith(
                              color: Colors.white,
                              fontWeight: .bold,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            'Run this command in your PC terminal:',
                            style: context.bodySmall.copyWith(
                              color: AppColors.cyberMuted,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const CommandCopyBox(
                  commandText:
                      'adb -d shell pm grant com.andikatp.devkit '
                      'android.permission.WRITE_SECURE_SETTINGS',
                ),
              ],
            ),
          ),
          const MultiDeviceHelperCard(),
          GrantStatusCard(
            isGranted: state.isDirectModeGranted,
            isVerifying: state.isVerifying,
            onVerify: cubit.verifyDirectModeGrant,
          ),
        ],
      ),
    );
  }
}
