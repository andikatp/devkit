import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:devkit/features/tools/application/tools_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimationScalerCard extends StatelessWidget {
  const new({super.key});

  void _onSelectScale(BuildContext context, double scale) {
    context.read<ToolsCubit>().setAnimationScale(scale: scale);
  }

  @override
  Widget build(BuildContext context) {
    final currentScale = context.watch<ToolsCubit>().state.animationScale;

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
                Icons.slow_motion_video,
                color: AppColors.cyanBright,
                size: 22,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  spacing: 2,
                  children: [
                    Text(
                      'Animation Scale Override',
                      style: context.labelMedium.copyWith(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: .bold,
                      ),
                    ),
                    Text(
                      'Adjust global window & transition duration scale',
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
            children: [0.5, 1.0, 2.0, 5.0].map((scale) {
              final isSelected = currentScale == scale;
              return ChoiceChip(
                label: Text(
                  '${scale}x',
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
                    _onSelectScale(context, scale);
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
