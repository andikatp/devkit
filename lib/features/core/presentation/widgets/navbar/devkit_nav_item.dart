import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class DevKitNavItem extends StatelessWidget {
  const new({
    required this.index,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
    this.isPro = false,
    this.isProUnlocked = false,
    super.key,
  });

  final int index;
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final bool isPro;
  final bool isProUnlocked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const .symmetric(vertical: 8, horizontal: 16),
        child: Column(
          mainAxisSize: .min,
          spacing: 2,
          children: [
            Stack(
              clipBehavior: .none,
              children: [
                Icon(
                  icon,
                  color: isActive ? AppColors.cyanBright : AppColors.cyberMuted,
                  size: 22,
                ),
                if (isPro && !isProUnlocked)
                  Positioned(
                    top: -4,
                    right: -12,
                    child: Container(
                      padding: const .symmetric(
                        horizontal: 3,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.cyberAmber,
                        borderRadius: .circular(3),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.cyberAmber,
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Text(
                        'PRO',
                        style: context.labelSmall.copyWith(
                          color: Colors.black,
                          fontSize: 7,
                          fontWeight: .w900,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Text(
              label,
              style: context.labelSmall.copyWith(
                color: isActive ? AppColors.cyanBright : AppColors.cyberMuted,
                fontSize: 10,
                fontWeight: .bold,
                letterSpacing: 0.5,
              ),
            ),
            Container(
              height: 2,
              width: 16,
              decoration: BoxDecoration(
                color: isActive ? AppColors.cyanBright : Colors.transparent,
                borderRadius: .circular(1),
                boxShadow: isActive
                    ? [
                        const BoxShadow(
                          color: AppColors.cyanBright,
                          blurRadius: 4,
                        ),
                      ]
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
