import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ToolsHeaderBarWidget extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Row(
          spacing: 8,
          children: [
            const Icon(
              Icons.construction,
              color: AppColors.cyanBright,
              size: 22,
            ),
            Text(
              'DEVELOPER TOOLS',
              style: context.titleMedium.copyWith(
                color: Colors.white,
                fontSize: 16,
                fontWeight: .bold,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        Container(
          padding: const .symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.cyberAmber.withValues(alpha: 0.2),
            borderRadius: .circular(4),
            border: Border.all(
              color: AppColors.cyberAmber.withValues(alpha: 0.5),
            ),
          ),
          child: Text(
            'PRO SUITE',
            style: context.labelSmall.copyWith(
              color: AppColors.cyberAmber,
              fontSize: 10,
              fontWeight: .bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }
}
