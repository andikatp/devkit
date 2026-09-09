import 'dart:async';

import 'package:devkit/features/tools/application/tools_cubit.dart';
import 'package:devkit/features/tools/presentation/widgets/scaler_options_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimationScalerCard extends StatelessWidget {
  const new({super.key});

  void _onSelectScale(BuildContext context, double scale) {
    unawaited(context.read<ToolsCubit>().setAnimationScale(scale: scale));
  }

  @override
  Widget build(BuildContext context) {
    final currentScale = context.watch<ToolsCubit>().state.animationScale;

    const options = [
      ScalerOptionItem<double>(label: '0.5x', value: 0.5),
      ScalerOptionItem<double>(label: '1.0x', value: 1),
      ScalerOptionItem<double>(label: '2.0x', value: 2),
      ScalerOptionItem<double>(label: '5.0x', value: 5),
    ];

    return ScalerOptionsCard<double>(
      title: 'Animation Scale Override',
      subtitle: 'Adjust global window & transition duration scale',
      icon: Icons.slow_motion_video,
      options: options,
      selectedValue: currentScale,
      onSelected: (val) => _onSelectScale(context, val),
      isSelected: (itemVal, selectedVal) => itemVal == selectedVal,
    );
  }
}
