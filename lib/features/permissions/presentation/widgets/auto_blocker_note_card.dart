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
                  'If your phone shows a "24-hour Security Delay" or'
                  ' "Apps from unverified developers" restriction, Android may'
                  ' block 1-tap toggles until the delay expires. You can still'
                  ' use Developer Options as a fallback.',
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
