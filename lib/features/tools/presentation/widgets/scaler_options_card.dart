import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ScalerOptionItem<T> {
  const new({
    required this.label,
    required this.value,
  });

  final String label;
  final T value;
}

class ScalerOptionsCard<T> extends StatelessWidget {
  const new({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.options,
    required this.selectedValue,
    required this.onSelected,
    required this.isSelected,
    super.key,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final List<ScalerOptionItem<T>> options;
  final T selectedValue;
  final ValueChanged<T> onSelected;
  final bool Function(T itemValue, T selectedValue) isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .all(12),
      decoration: BoxDecoration(
        color: AppColors.cyberCard,
        borderRadius: .circular(8),
        border: .all(color: AppColors.cyberBorder),
      ),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 10,
        children: [
          Row(
            spacing: 12,
            children: [
              Icon(icon, color: AppColors.cyanBright, size: 22),
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  spacing: 2,
                  children: [
                    Text(
                      title,
                      style: context.labelMedium.copyWith(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: .bold,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: context.bodySmall.copyWith(
                        color: AppColors.cyberMuted,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: .spaceAround,
            children: options.map((item) {
              final selected = isSelected(item.value, selectedValue);
              return ChoiceChip(
                label: Text(
                  item.label,
                  style: context.labelSmall.copyWith(
                    fontSize: 10,
                    fontWeight: .bold,
                    color: selected ? Colors.white : AppColors.cyanBright,
                  ),
                ),
                selected: selected,
                selectedColor: AppColors.deepBlue,
                backgroundColor: AppColors.cyberCardAlt,
                shape: RoundedRectangleBorder(
                  borderRadius: .circular(4),
                  side: BorderSide(
                    color: selected
                        ? AppColors.cyanBright
                        : AppColors.cyberBorder,
                  ),
                ),
                onSelected: (val) {
                  if (val) {
                    onSelected(item.value);
                  }
                },
                visualDensity: .compact,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
