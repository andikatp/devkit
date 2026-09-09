import 'dart:async';

import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:devkit/features/tools/application/tools_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FontScalerCard extends StatelessWidget {
  const new({super.key});

  void _onSelectScale(BuildContext context, double scale) {
    unawaited(context.read<ToolsCubit>().setFontScale(scale: scale));
  }

  @override
  Widget build(BuildContext context) {
    final currentScale = context.watch<ToolsCubit>().state.fontScale;

    final scales = [
      (label: 'Small', value: 0.85),
      (label: 'Normal', value: 1.0),
      (label: 'Large', value: 1.15),
      (label: 'Huge', value: 1.30),
    ];

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
              const Icon(
                Icons.format_size,
                color: AppColors.cyanBright,
                size: 22,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  spacing: 2,
                  children: [
                    Text(
                      'Font Scale Multiplier',
                      style: context.labelMedium.copyWith(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: .bold,
                      ),
                    ),
                    Text(
                      'Test text overflow and accessibility scale in 1 tap',
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
            children: scales.map((item) {
              final isSelected = (currentScale - item.value).abs() < 0.05;
              return ChoiceChip(
                label: Text(
                  item.label,
                  style: context.labelSmall.copyWith(
                    fontSize: 10,
                    fontWeight: .bold,
                    color: isSelected ? Colors.white : AppColors.cyanBright,
                  ),
                ),
                selected: isSelected,
                selectedColor: AppColors.deepBlue,
                backgroundColor: AppColors.cyberCardAlt,
                shape: RoundedRectangleBorder(
                  borderRadius: .circular(4),
                  side: BorderSide(
                    color: isSelected
                        ? AppColors.cyanBright
                        : AppColors.cyberBorder,
                  ),
                ),
                onSelected: (val) {
                  if (val) {
                    _onSelectScale(context, item.value);
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
