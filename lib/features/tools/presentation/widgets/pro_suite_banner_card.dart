import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:glow_container/glow_container.dart';

class ProSuiteBannerCard extends StatelessWidget {
  const new({required this.onOpenPaywallModal, super.key});

  final VoidCallback onOpenPaywallModal;

  @override
  Widget build(BuildContext context) {
    return GlowContainer(
      gradientColors: const [
        AppColors.cyberAmber,
        AppColors.cyanBright,
        AppColors.deepBlue,
      ],
      glowRadius: 6,
      rotationDuration: const Duration(seconds: 5),
      containerOptions: const ContainerOptions(
        backgroundColor: AppColors.cyberCard,
        borderRadius: 12,
        borderSide: BorderSide(
          color: AppColors.cyberAmber,
          width: 1.5,
        ),
        padding: EdgeInsets.all(14),
      ),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 8,
        children: [
          Row(
            children: [
              Text(
                '❤️ ',
                style: context.bodyMedium.copyWith(fontSize: 16),
              ),
              Text(
                'SUPPORT DEVKIT CREATOR',
                style: context.titleSmall.copyWith(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: .bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          Text(
            'DevKit is independently built. Support ongoing open-source '
            'updates, new developer utilities, and creator coffee funds.',
            style: context.bodySmall.copyWith(
              color: AppColors.cyberMuted,
              fontSize: 11,
              height: 1.3,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onOpenPaywallModal,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.cyberAmber,
                foregroundColor: Colors.black,
                padding: const .symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: .circular(6),
                ),
              ),
              child: Row(
                mainAxisAlignment: .center,
                children: [
                  Text(
                    '☕ ',
                    style: context.bodyMedium.copyWith(fontSize: 14),
                  ),
                  Text(
                    'DONATE TO CREATOR',
                    style: context.labelSmall.copyWith(
                      color: Colors.black,
                      fontWeight: .bold,
                      fontSize: 11,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
