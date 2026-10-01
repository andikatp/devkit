import 'package:devkit/core/theme/app_theme.dart';
import 'package:devkit/features/core/presentation/widgets/header_widget.dart';
import 'package:devkit/features/home/application/devkit_dashboard_cubit.dart';
import 'package:devkit/features/home/application/devkit_dashboard_state.dart';
import 'package:devkit/features/home/presentation/widgets/connect_command_card.dart';
import 'package:devkit/features/home/presentation/widgets/pair_command_card.dart';
import 'package:devkit/features/home/presentation/widgets/recent_actions_widget.dart';
import 'package:devkit/features/home/presentation/widgets/state_toggles_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DevKitDashboardView extends StatelessWidget {
  const new({super.key});

  void _onStateListener(BuildContext context, DevKitDashboardState state) {
    if (state.successMessage != null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            state.successMessage!,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          backgroundColor: AppColors.cyberDark,
          behavior: .fixed,
          duration: const Duration(seconds: 2),
        ),
      );
    } else if (state.errorMessage != null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            state.errorMessage!,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          backgroundColor: AppColors.cyberRed,
          behavior: .fixed,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DevKitDashboardCubit>().state;
    final isPairing = state.consoleState.pairingPort > 0;

    return BlocListener<DevKitDashboardCubit, DevKitDashboardState>(
      listener: _onStateListener,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 28,
          children: [
            const HeaderWidget(),
            const RecentActionsWidget(),
            const StateTogglesCard(),
            if (isPairing)
              const PairCommandCard()
            else
              const ConnectCommandCard(stepNumber: '03'),
          ],
        ),
      ),
    );
  }
}
