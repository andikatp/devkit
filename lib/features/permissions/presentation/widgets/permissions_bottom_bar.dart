import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PermissionsBottomBar extends StatelessWidget {
  const new({
    required this.currentStep,
    required this.isDirectModeGranted,
    required this.onContinue,
    required this.onFinish,
    required this.onSkip,
    super.key,
  });

  final int currentStep;
  final bool isDirectModeGranted;
  final VoidCallback onContinue;
  final VoidCallback onFinish;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    if (currentStep == 1) {
      return SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: onContinue,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.cyanBright,
            foregroundColor: AppColors.cyberBlack,
            shape: RoundedRectangleBorder(
              borderRadius: .circular(10),
            ),
            elevation: 0,
          ),
          child: Row(
            mainAxisAlignment: .center,
            spacing: 8,
            children: [
              Text(
                'Continue to Step 2',
                style: context.labelMedium.copyWith(
                  color: AppColors.cyberBlack,
                  fontWeight: .bold,
                  fontSize: 14,
                ),
              ),
              const Icon(
                Icons.arrow_forward,
                color: AppColors.cyberBlack,
                size: 16,
              ),
            ],
          ),
        ),
      );
    }

    // Step 2
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: isDirectModeGranted ? onFinish : onSkip,
        style: ElevatedButton.styleFrom(
          backgroundColor: isDirectModeGranted
              ? AppColors.cyanBright
              : AppColors.cyberCardAlt,
          foregroundColor: isDirectModeGranted
              ? AppColors.cyberBlack
              : AppColors.cyanBright,
          shape: RoundedRectangleBorder(
            borderRadius: .circular(10),
            side: isDirectModeGranted
                ? BorderSide.none
                : const BorderSide(color: AppColors.cyberBorder),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: .center,
          spacing: 8,
          children: [
            Text(
              isDirectModeGranted
                  ? 'Finish & Open Console'
                  : 'Skip & Open Console',
              style: context.labelMedium.copyWith(
                color: isDirectModeGranted
                    ? AppColors.cyberBlack
                    : AppColors.cyanBright,
                fontWeight: .bold,
                fontSize: 14,
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: isDirectModeGranted
                  ? AppColors.cyberBlack
                  : AppColors.cyanBright,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
