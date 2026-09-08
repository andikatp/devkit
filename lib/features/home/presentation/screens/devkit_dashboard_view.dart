import 'package:devkit/features/core/presentation/widgets/header_widget.dart';
import 'package:devkit/features/home/presentation/widgets/connect_command_card.dart';
import 'package:devkit/features/home/presentation/widgets/recent_actions_widget.dart';
import 'package:devkit/features/home/presentation/widgets/state_toggles_card.dart';
import 'package:flutter/material.dart';

class DevKitDashboardView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: .all(16),
      child: Column(
        spacing: 28,
        children: [
          HeaderWidget(),
          RecentActionsWidget(),
          StateTogglesCard(),
          ConnectCommandCard(),
        ],
      ),
    );
  }
}
