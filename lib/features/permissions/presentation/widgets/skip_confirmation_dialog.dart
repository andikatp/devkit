import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SkipConfirmationDialog extends StatelessWidget {
  const new({super.key});

  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (_) => const SkipConfirmationDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.cyberCard,
      shape: RoundedRectangleBorder(
        borderRadius: .circular(16),
        side: const BorderSide(color: AppColors.cyberBorder),
      ),
      contentPadding: const .all(20),
      title: Row(
        spacing: 10,
        children: [
          Container(
            padding: const .all(8),
            decoration: BoxDecoration(
              color: AppColors.cyberAmber.withValues(alpha: 0.15),
              borderRadius: .circular(8),
              border: .all(
                color: AppColors.cyberAmber.withValues(alpha: 0.6),
              ),
            ),
            child: const Icon(
              Icons.warning_amber_rounded,
              color: AppColors.cyberAmber,
              size: 20,
            ),
          ),
          Expanded(
            child: Text(
              'Skip Direct Mode?',
              style: context.headlineSmall.copyWith(
                color: Colors.white,
                fontWeight: .bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      content: Text(
        'DevKit will run in SHORTCUT mode. Toggling options will open '
        'system settings pages via intent shortcut until Direct Mode '
        'permission is granted via ADB.',
        style: context.bodySmall.copyWith(
          color: AppColors.cyberMuted,
          fontSize: 12,
          height: 1.4,
        ),
      ),
      actionsPadding: const .fromLTRB(16, 0, 16, 16),
      actions: [
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(false),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.cyberBorder),
                  shape: RoundedRectangleBorder(
                    borderRadius: .circular(8),
                  ),
                ),
                child: Text(
                  'Go Back',
                  style: context.labelSmall.copyWith(
                    color: AppColors.cyberMuted,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.cyanBright,
                  foregroundColor: AppColors.cyberBlack,
                  shape: RoundedRectangleBorder(
                    borderRadius: .circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Proceed',
                  style: context.labelSmall.copyWith(
                    color: AppColors.cyberBlack,
                    fontWeight: .bold,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
