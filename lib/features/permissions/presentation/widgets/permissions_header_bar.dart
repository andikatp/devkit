import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PermissionsHeaderBar extends StatelessWidget {
  const new({
    required this.currentStep,
    required this.totalSteps,
    required this.onBack,
    super.key,
  });

  final int currentStep;
  final int totalSteps;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final progressFraction = currentStep / totalSteps;

    return Column(
      spacing: 16,
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            InkWell(
              onTap: onBack,
              borderRadius: .circular(8),
              child: Container(
                padding: const .all(8),
                decoration: BoxDecoration(
                  color: AppColors.cyberCardAlt,
                  borderRadius: .circular(8),
                  border: .all(color: AppColors.cyberBorder),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            Container(
              padding: const .symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.cyberCardAlt,
                borderRadius: .circular(16),
                border: .all(color: AppColors.cyberBorder),
              ),
              child: Text(
                '$currentStep of $totalSteps',
                style: context.labelSmall.copyWith(
                  color: AppColors.cyberMuted,
                  fontSize: 11,
                  fontWeight: .bold,
                ),
              ),
            ),
          ],
        ),
        Stack(
          children: [
            Container(
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.cyberCardAlt,
                borderRadius: .circular(2),
              ),
            ),
            FractionallySizedBox(
              widthFactor: progressFraction,
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.cyanBright,
                  borderRadius: .circular(2),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.cyanBright,
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
