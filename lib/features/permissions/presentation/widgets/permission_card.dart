import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PermissionCard extends StatelessWidget {
  const new({
    required this.title,
    required this.description,
    required this.icon,
    required this.footerLabel,
    required this.isGranted,
    required this.onAllow,
    super.key,
  });

  final String title;
  final String description;
  final IconData icon;
  final String footerLabel;
  final bool isGranted;
  final VoidCallback onAllow;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            crossAxisAlignment: .start,
            spacing: 12,
            children: [
              Container(
                padding: const .all(10),
                decoration: BoxDecoration(
                  color: AppColors.cyberCardDeep,
                  borderRadius: .circular(10),
                  border: .all(
                    color: AppColors.cyanBright.withValues(alpha: 0.3),
                  ),
                ),
                child: Icon(
                  icon,
                  color: AppColors.cyanBright,
                  size: 22,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  spacing: 4,
                  children: [
                    Text(
                      title,
                      style: context.labelMedium.copyWith(
                        color: Colors.white,
                        fontWeight: .bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      description,
                      style: context.bodySmall.copyWith(
                        color: AppColors.cyberMuted,
                        fontSize: 12,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(color: AppColors.cyberCardAlt, height: 1),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                footerLabel,
                style: context.labelSmall.copyWith(
                  color: AppColors.cyberMuted,
                  fontSize: 11,
                  fontFamily: 'monospace',
                ),
              ),
              if (isGranted)
                Container(
                  padding: const .symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.cyberEmerald.withValues(alpha: 0.15),
                    borderRadius: .circular(6),
                    border: .all(
                      color: AppColors.cyberEmerald.withValues(alpha: 0.6),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: .min,
                    spacing: 4,
                    children: [
                      const Icon(
                        Icons.check,
                        color: AppColors.cyberEmerald,
                        size: 12,
                      ),
                      Text(
                        'Granted',
                        style: context.labelSmall.copyWith(
                          color: AppColors.cyberEmerald,
                          fontSize: 11,
                          fontWeight: .bold,
                        ),
                      ),
                    ],
                  ),
                )
              else
                ElevatedButton(
                  onPressed: onAllow,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.cyanBright,
                    foregroundColor: AppColors.cyberBlack,
                    elevation: 0,
                    padding: const .symmetric(horizontal: 16, vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: .circular(6),
                    ),
                  ),
                  child: Text(
                    'Allow',
                    style: context.labelSmall.copyWith(
                      color: AppColors.cyberBlack,
                      fontWeight: .bold,
                      fontSize: 11,
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
