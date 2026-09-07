import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ToolSwitchCard extends StatelessWidget {
  const new({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .all(12),
      decoration: BoxDecoration(
        color: AppColors.cyberCard,
        borderRadius: .circular(8),
        border: Border.all(color: AppColors.cyberBorder),
      ),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Expanded(
            child: Row(
              spacing: 12,
              children: [
                Icon(icon, color: AppColors.cyanBright, size: 22),
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    spacing: 2,
                    children: [
                      Text(
                        title,
                        style: context.labelMedium.copyWith(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: .bold,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: context.bodySmall.copyWith(
                          color: AppColors.cyberMuted,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeTrackColor: AppColors.deepBlue,
            inactiveThumbColor: AppColors.cyberDim,
            inactiveTrackColor: AppColors.cyberCardAlt,
          ),
        ],
      ),
    );
  }
}
