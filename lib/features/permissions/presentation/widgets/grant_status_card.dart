import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class GrantStatusCard extends StatelessWidget {
  const new({
    required this.isGranted,
    required this.isVerifying,
    required this.onVerify,
    super.key,
  });

  final bool isGranted;
  final bool isVerifying;
  final VoidCallback onVerify;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .all(14),
      decoration: BoxDecoration(
        color: AppColors.cyberCard,
        borderRadius: .circular(10),
        border: .all(
          color: isGranted ? AppColors.cyberEmerald : AppColors.cyberBorder,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const .all(8),
            decoration: BoxDecoration(
              color: AppColors.cyberCardAlt,
              borderRadius: .circular(8),
            ),
            child: Icon(
              isGranted ? Icons.check_circle : Icons.sync,
              color: isGranted ? AppColors.cyberEmerald : AppColors.cyanBright,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  'Permission Status',
                  style: context.labelSmall.copyWith(
                    color: Colors.white,
                    fontWeight: .bold,
                    fontSize: 12,
                  ),
                ),
                Text(
                  isGranted ? 'Granted ✓' : 'Waiting for grant...',
                  style: context.bodySmall.copyWith(
                    color: isGranted
                        ? AppColors.cyberEmerald
                        : AppColors.cyberMuted,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: isVerifying ? null : onVerify,
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: isGranted
                    ? AppColors.cyberEmerald
                    : AppColors.cyberBorder,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: .circular(6),
              ),
              padding: const .symmetric(horizontal: 12, vertical: 6),
            ),
            child: isVerifying
                ? const SizedBox(
                    width: 12,
                    height: 12,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.cyanBright,
                    ),
                  )
                : Text(
                    'Verify Grant',
                    style: context.labelSmall.copyWith(
                      color: isGranted
                          ? AppColors.cyberEmerald
                          : AppColors.cyanBright,
                      fontWeight: .bold,
                      fontSize: 11,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
