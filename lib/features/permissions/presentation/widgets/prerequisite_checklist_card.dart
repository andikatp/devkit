import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/services/permission_service.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PrerequisiteChecklistCard extends StatelessWidget {
  const new({super.key});

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
        spacing: 14,
        children: [
          Row(
            spacing: 8,
            children: [
              const Icon(
                Icons.checklist_rtl_rounded,
                color: AppColors.cyanBright,
                size: 18,
              ),
              Text(
                'PREREQUISITE CHECKLIST',
                style: context.labelSmall.copyWith(
                  color: AppColors.cyanBright,
                  fontWeight: .bold,
                  fontSize: 11,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const Divider(color: AppColors.cyberCardAlt, height: 1),
          // Step 1
          _buildChecklistItem(
            context,
            stepNumber: '1',
            title: 'Enable USB Debugging manually on your device',
            actionWidget: OutlinedButton.icon(
              onPressed: PermissionService.openDeveloperSettings,
              icon: const Icon(
                Icons.open_in_new,
                color: AppColors.cyanBright,
                size: 14,
              ),
              label: Text(
                'Open Developer Settings',
                style: context.labelSmall.copyWith(
                  color: AppColors.cyanBright,
                  fontSize: 11,
                  fontWeight: .bold,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.cyberBorder),
                shape: RoundedRectangleBorder(
                  borderRadius: .circular(6),
                ),
                padding: const .symmetric(horizontal: 10, vertical: 4),
              ),
            ),
          ),
          // Step 2
          _buildChecklistItem(
            context,
            stepNumber: '2',
            title:
                'Connect phone to computer via USB cable and tap '
                '"Always allow from this computer" on the system RSA prompt.',
          ),
          // Step 3
          _buildChecklistItem(
            context,
            stepNumber: '3',
            title: 'Run the setup command in your terminal below.',
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistItem(
    BuildContext context, {
    required String stepNumber,
    required String title,
    Widget? actionWidget,
  }) {
    return Row(
      crossAxisAlignment: .start,
      spacing: 12,
      children: [
        Container(
          width: 22,
          height: 22,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.cyberCardAlt,
            border: Border.all(color: AppColors.cyberBorder),
          ),
          child: Text(
            stepNumber,
            style: context.labelSmall.copyWith(
              color: AppColors.cyanBright,
              fontWeight: .bold,
              fontSize: 11,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            spacing: 8,
            children: [
              Text(
                title,
                style: context.bodySmall.copyWith(
                  color: Colors.white,
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
              ?actionWidget,
            ],
          ),
        ),
      ],
    );
  }
}
