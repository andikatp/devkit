import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:devkit/features/permissions/application/permissions_cubit.dart';
import 'package:devkit/features/permissions/presentation/widgets/basic_permissions_step/location_accordion_card.dart';
import 'package:devkit/features/permissions/presentation/widgets/permission_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasicPermissionsStep extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<PermissionsCubit>();
    final state = cubit.state;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: .start,
        spacing: 20,
        children: [
          Column(
            crossAxisAlignment: .start,
            spacing: 6,
            children: [
              Text(
                'STEP 1 OF 2 • BASIC ACCESS',
                style: context.labelSmall.copyWith(
                  color: AppColors.cyanBright,
                  fontSize: 11,
                  fontWeight: .bold,
                  letterSpacing: 1,
                ),
              ),
              Text(
                'Setup Permissions',
                style: context.headlineSmall.copyWith(
                  color: Colors.white,
                  fontWeight: .bold,
                ),
              ),
              Text(
                'DevKit requires local network and notification access to '
                'detect your device and stream wireless debugging.',
                style: context.bodySmall.copyWith(
                  color: AppColors.cyberMuted,
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
            ],
          ),
          PermissionCard(
            title: 'Nearby Wi-Fi & Devices',
            description:
                'Allows discovering dynamic wireless ADB ports on your '
                'local Wi-Fi automatically.',
            icon: Icons.wifi_tethering,
            footerLabel: 'Required for pairing',
            isGranted: state.isNearbyWifiGranted,
            onAllow: cubit.requestNearbyWifi,
          ),
          PermissionCard(
            title: 'Notifications',
            description:
                'Shows active connection status and quick toggles in your '
                'status bar.',
            icon: Icons.notifications_none,
            footerLabel: 'Status bar telemetry',
            isGranted: state.isNotificationGranted,
            onAllow: cubit.requestNotification,
          ),
          const LocationAccordionCard(),
        ],
      ),
    );
  }
}
