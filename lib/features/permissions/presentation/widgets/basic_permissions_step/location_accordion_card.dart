import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:devkit/features/permissions/application/permissions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationAccordionCard extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<PermissionsCubit>();
    final isLocationGranted = cubit.state.isLocationGranted;

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
                  if (!isLocationGranted)
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
