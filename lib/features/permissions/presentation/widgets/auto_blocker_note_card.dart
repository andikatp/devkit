import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AutoBlockerNoteCard extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .all(12),
      decoration: BoxDecoration(
        color: AppColors.cyberCardAlt,
        borderRadius: .circular(8),
        border: .all(color: AppColors.cyberBorder),
      ),
      child: Row(
        spacing: 10,
        crossAxisAlignment: .start,
        children: [
          const Icon(
            Icons.shield_outlined,
            color: AppColors.cyanBright,
            size: 18,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              spacing: 4,
              children: [
                Text(
                  'Android Security Delay & Permission Tip',
                  style: context.labelSmall.copyWith(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: .bold,
                  ),
                ),
                Text(
                  'On Samsung / Android 14+, turn off "Auto Blocker" '
                  '(Settings > Security & Privacy > Auto Blocker) and enable '
                  '"Allow apps from unverified developers" in Developer '
                  'Options. Otherwise, Android may enforce a 24-hour delay or '
                  'block 1-tap toggles.',
                  style: context.bodySmall.copyWith(
                    color: AppColors.cyberMuted,
                    fontSize: 10,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
