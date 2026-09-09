import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:devkit/features/core/presentation/widgets/header_widget.dart';
import 'package:devkit/features/tools/application/tools_cubit.dart';
import 'package:devkit/features/tools/presentation/widgets/animation_scaler_card.dart';
import 'package:devkit/features/tools/presentation/widgets/pro_suite_banner_card.dart';
import 'package:devkit/features/tools/presentation/widgets/tool_switch_card.dart';
import 'package:devkit/features/tools/presentation/widgets/tools_header_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToolsScreen extends StatelessWidget {
  const new({required this.onOpenPaywallModal, super.key});

  final VoidCallback onOpenPaywallModal;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ToolsCubit>();
    final toolsState = context.watch<ToolsCubit>().state;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          const HeaderWidget(),
          const ToolsHeaderBarWidget(),
          ProSuiteBannerCard(onOpenPaywallModal: onOpenPaywallModal),
          Text(
            'QUICK TOGGLE UTILITIES',
            style: context.labelSmall.copyWith(
              color: AppColors.cyberMuted,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          ToolSwitchCard(
            title: 'Show Layout Bounds',
            subtitle: 'Draw clip bounds, margins, and layout grids',
            icon: Icons.border_clear,
            value: toolsState.showLayoutBounds,
            onChanged: (val) => cubit.toggleLayoutBounds(value: val),
          ),
          ToolSwitchCard(
            title: 'Show Taps & Touches',
            subtitle: 'Display visual feedback for touch events',
            icon: Icons.touch_app,
            value: toolsState.showTaps,
            onChanged: (val) => cubit.toggleTaps(value: val),
          ),
          ToolSwitchCard(
            title: 'Pointer Location',
            subtitle: 'Screen overlay showing touch coordinates',
            icon: Icons.ads_click,
            value: toolsState.showPointerLocation,
            onChanged: (val) => cubit.togglePointerLocation(value: val),
          ),
          const AnimationScalerCard(),
          ToolSwitchCard(
            title: 'GPU Rendering Profile',
            subtitle:
                'Bars on screen showing GPU rendering performance',
            icon: Icons.speed,
            value: toolsState.gpuProfiling,
            onChanged: (val) => cubit.toggleGpuProfiling(value: val),
          ),
          ToolSwitchCard(
            title: 'Strict Mode Flashes',
            subtitle:
                'Flash screen when apps do long main thread operations',
            icon: Icons.flash_on,
            value: toolsState.strictMode,
            onChanged: (val) => cubit.toggleStrictMode(value: val),
          ),
        ],
      ),
    );
  }
}
