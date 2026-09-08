import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PaywallTierOptionCard extends StatelessWidget {
  const new({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.badgeText,
    required this.isSelected,
    required this.onTap,
    this.isPopular = false,
    super.key,
  });

  final int index;
  final String title;
  final String subtitle;
  final String badgeText;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isPopular;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: .circular(6),
      child: Container(
        padding: const .all(10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.deepBlue.withValues(alpha: 0.2)
              : AppColors.cyberCardAlt,
          borderRadius: .circular(6),
          border: .all(
            color: isSelected ? AppColors.cyanBright : AppColors.cyberBorder,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.cyanBright.withValues(alpha: 0.2),
                    blurRadius: 8,
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Expanded(
              child: Row(
                spacing: 8,
                children: [
                  Icon(
                    isSelected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color: isSelected
                        ? AppColors.cyanBright
                        : AppColors.cyberMuted,
                    size: 18,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      spacing: 2,
                      children: [
                        Row(
                          spacing: 6,
                          children: [
                            Flexible(
                              child: Text(
                                title,
                                style: context.titleSmall.copyWith(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: .bold,
                                ),
                                overflow: .ellipsis,
                              ),
                            ),
                            if (isPopular)
                              Container(
                                padding: const .symmetric(
                                  horizontal: 4,
                                  vertical: 1,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.cyanBright,
                                  borderRadius: .circular(3),
                                ),
                                child: Text(
                                  'POPULAR',
                                  style: context.labelSmall.copyWith(
                                    color: Colors.black,
                                    fontSize: 8,
                                    fontWeight: .w900,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        Text(
                          subtitle,
                          style: context.bodySmall.copyWith(
                            color: isSelected
                                ? AppColors.cyanBright
                                : AppColors.cyberMuted,
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
            Text(
              badgeText,
              style: context.labelSmall.copyWith(
                color: isSelected ? AppColors.cyanBright : AppColors.cyberMuted,
                fontSize: 10,
                fontWeight: .bold,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
