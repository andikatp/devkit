import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:devkit/features/permissions/application/permissions_cubit.dart';
import 'package:devkit/features/permissions/application/permissions_state.dart';
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
          _buildLocationAccordion(context, cubit, state),
        ],
      ),
    );
  }

  Widget _buildLocationAccordion(
    BuildContext context,
    PermissionsCubit cubit,
    PermissionsState state,
  ) {
    return Material(
      color: AppColors.cyberCardAlt,
      shape: RoundedRectangleBorder(
        borderRadius: .circular(10),
        side: const BorderSide(color: AppColors.cyberBorder),
      ),
      clipBehavior: .antiAlias,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: AppColors.cyberMuted,
          collapsedIconColor: AppColors.cyberMuted,
          leading: const Icon(
            Icons.info_outline,
            color: AppColors.cyberMuted,
            size: 18,
          ),
          title: Text(
            'Location permission on Android 10–12',
            style: context.labelSmall.copyWith(
              color: Colors.white,
              fontSize: 12,
              fontWeight: .w600,
            ),
          ),
          children: [
            Padding(
              padding: const .fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: .start,
                spacing: 10,
                children: [
                  Text(
                    'On Android 10 to 12, Android OS requires Location '
                    'permission to read Wi-Fi network details (SSID/IP). '
                    'DevKit never tracks your location.',
                    style: context.bodySmall.copyWith(
                      color: AppColors.cyberMuted,
                      fontSize: 11,
                    ),
                  ),
                  if (!state.isLocationGranted)
                    OutlinedButton(
                      onPressed: cubit.requestLocation,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.cyberBorder),
                        shape: RoundedRectangleBorder(
                          borderRadius: .circular(6),
                        ),
                      ),
                      child: Text(
                        'Grant Location Permission',
                        style: context.labelSmall.copyWith(
                          color: AppColors.cyanBright,
                          fontSize: 11,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
