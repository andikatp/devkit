import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class QuickActionChipWidget extends StatelessWidget {
  const new({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isSelected = false,
    this.activeColor = AppColors.cyanBright,
    super.key,
  });

  final Widget icon;
  final String label;
  final VoidCallback onTap;
  final bool isSelected;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    final bgColor = isSelected
        ? activeColor.withValues(alpha: 0.22)
        : AppColors.cyberCard;
    final borderColor = isSelected
        ? activeColor
        : AppColors.cyberBorder.withValues(alpha: 0.7);

    return Material(
      color: bgColor,
      borderRadius: .circular(6),
      child: InkWell(
        onTap: onTap,
        borderRadius: .circular(6),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const .symmetric(vertical: 10, horizontal: 6),
          decoration: BoxDecoration(
            borderRadius: .circular(6),
            border: .all(color: borderColor, width: isSelected ? 1.5 : 1.0),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: activeColor.withValues(alpha: 0.3),
                      blurRadius: 8,
                    ),
                  ]
                : const [],
          ),
          child: Row(
            mainAxisAlignment: .center,
            spacing: 6,
            children: [
              icon,
              Flexible(
                child: Text(
                  label,
                  style: context.labelSmall.copyWith(
                    color: isSelected ? activeColor : Colors.white,
                    fontSize: 10,
                    fontWeight: .bold,
                    letterSpacing: 0.5,
                  ),
                  overflow: .ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
