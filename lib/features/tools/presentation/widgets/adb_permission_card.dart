import 'dart:async';

import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:devkit/features/permissions/presentation/widgets/auto_blocker_note_card.dart';
import 'package:devkit/features/tools/application/tools_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdbPermissionCard extends StatelessWidget {
  const new({super.key});

  void _onCopyCommand(BuildContext context) {
    unawaited(context.read<ToolsCubit>().copyAdbCommand());
  }

  void _onOpenDevSettings(BuildContext context) {
    unawaited(context.read<ToolsCubit>().openDeveloperSettings());
  }

  void _onDismiss(BuildContext context) {
    context.read<ToolsCubit>().setCardDismissed(value: true);
  }

  @override
  Widget build(BuildContext context) {
    final isAdbGranted = context.select<ToolsCubit, bool>(
      (c) => c.state.isAdbGranted,
    );
    final isDirectWriteBlocked = context.select<ToolsCubit, bool>(
      (c) => c.state.isDirectWriteBlocked,
    );
    final isCardDismissed = context.select<ToolsCubit, bool>(
      (c) => c.state.isCardDismissed,
    );

    if (isCardDismissed || (isAdbGranted && !isDirectWriteBlocked)) {
      return const SizedBox.shrink();
    }

    final isBlockedMode = isAdbGranted && isDirectWriteBlocked;

    return Container(
      padding: const .all(12),
      decoration: BoxDecoration(
        color: AppColors.cyberAmber.withValues(alpha: 0.1),
        borderRadius: .circular(8),
        border: .all(color: AppColors.cyberAmber.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 10,
        children: [
          Row(
            spacing: 8,
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                color: AppColors.cyberAmber,
                size: 20,
              ),
              Expanded(
                child: Text(
                  isBlockedMode
                      ? 'DIRECT WRITE BLOCKED BY OS'
                      : 'DIRECT ADB MODE RECOMMENDED',
                  style: context.titleSmall.copyWith(
                    color: AppColors.cyberAmber,
                    fontSize: 11,
                    fontWeight: .bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              InkWell(
                onTap: () => _onDismiss(context),
                borderRadius: .circular(12),
                child: const Padding(
                  padding: .all(2),
                  child: Icon(
                    Icons.close,
                    color: AppColors.cyberMuted,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          Text(
            isBlockedMode
                ? 'Your device OS or Auto Blocker is restricting direct 1-tap '
                    'setting writes even with ADB granted. Open Developer '
                    'Settings to toggle manually:'
                : 'To enable 1-tap direct toggles without opening system '
                    'settings, grant WRITE_SECURE_SETTINGS via ADB:',
            style: context.bodySmall.copyWith(
              color: AppColors.cyberMuted,
              fontSize: 11,
              height: 1.3,
            ),
          ),
          if (!isBlockedMode)
            Container(
              padding: const .symmetric(horizontal: 8, vertical: 6),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                borderRadius: .circular(4),
                border: .all(color: AppColors.cyberBorder),
              ),
              child: Text(
                ToolsCubit.adbCommandString,
                style: context.bodySmall.copyWith(
                  color: AppColors.cyanBright,
                  fontSize: 10,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          const AutoBlockerNoteCard(),
          Row(
            spacing: 8,
            children: [
              if (!isBlockedMode)
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _onCopyCommand(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.cyberAmber,
                      side: const BorderSide(color: AppColors.cyberAmber),
                      padding: const .symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: .circular(6),
                      ),
                    ),
                    icon: const Icon(Icons.copy, size: 14),
                    label: Text(
                      'COPY COMMAND',
                      style: context.labelSmall.copyWith(
                        color: AppColors.cyberAmber,
                        fontSize: 10,
                        fontWeight: .bold,
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _onOpenDevSettings(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.cyanBright,
                    side: const BorderSide(color: AppColors.cyanBright),
                    padding: const .symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: .circular(6),
                    ),
                  ),
                  icon: const Icon(Icons.settings, size: 14),
                  label: Text(
                    'DEV OPTIONS',
                    style: context.labelSmall.copyWith(
                      color: AppColors.cyanBright,
                      fontSize: 10,
                      fontWeight: .bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
