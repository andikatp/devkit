import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ToggleRowWidget extends StatelessWidget {
  const new({
    required this.title,
    required this.icon,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final String title;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      spacing: 8,
      children: [
        Expanded(
          child: Row(
            spacing: 10,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: .circle,
                  color: value ? AppColors.cyanBright : AppColors.cyberRed,
                  boxShadow: [
                    BoxShadow(
                      color: value ? AppColors.cyanBright : AppColors.cyberRed,
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
              Icon(icon, color: AppColors.cyberMuted, size: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      title,
                      style: context.labelSmall.copyWith(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: .bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      value ? 'On' : 'Off',
                      style: context.labelSmall.copyWith(
                        color: value
                            ? AppColors.cyanBright
                            : AppColors.cyberRed,
                        fontSize: 11,
                        fontWeight: .w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Switch.adaptive(
          value: value,
          onChanged: onChanged,
          activeTrackColor: AppColors.deepBlue,
          inactiveThumbColor: AppColors.cyberDim,
          inactiveTrackColor: AppColors.cyberCardAlt,
        ),
      ],
    );
  }
}
