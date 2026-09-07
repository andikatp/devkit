import 'package:devkit/core/di/injection_container.dart';
import 'package:devkit/features/core/presentation/widgets/header_widget.dart';
import 'package:devkit/features/home/application/devkit_dashboard_cubit.dart';
import 'package:devkit/features/home/presentation/widgets/connect_command_card.dart';
import 'package:devkit/features/home/presentation/widgets/recent_actions_widget.dart';
import 'package:devkit/features/home/presentation/widgets/state_toggles_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DevKitDashboardView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DevKitDashboardCubit>(),
      child: const SingleChildScrollView(
        padding: .symmetric(horizontal: 16, vertical: 8),
        child: Column(
          spacing: 24,
          children: [
            HeaderWidget(),
            RecentActionsWidget(),
            StateTogglesCard(),
            ConnectCommandCard(),
          ],
        ),
      ),
    );
  }
}
