import 'dart:async';

import 'package:devkit/features/tools/application/tools_cubit.dart';
import 'package:devkit/features/tools/presentation/widgets/scaler_options_card.dart';
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

    const options = [
      ScalerOptionItem<double>(label: 'Small', value: 0.85),
      ScalerOptionItem<double>(label: 'Normal', value: 1),
      ScalerOptionItem<double>(label: 'Large', value: 1.15),
      ScalerOptionItem<double>(label: 'Huge', value: 1.3),
    ];

    return ScalerOptionsCard<double>(
      title: 'Font Scale Multiplier',
      subtitle: 'Test text overflow and accessibility scale in 1 tap',
      icon: Icons.format_size,
      options: options,
      selectedValue: currentScale,
      onSelected: (val) => _onSelectScale(context, val),
      isSelected: (itemVal, selectedVal) =>
          (itemVal - selectedVal).abs() < 0.05,
    );
  }
}
