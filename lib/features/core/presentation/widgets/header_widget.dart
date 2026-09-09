import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/services/device_info_service.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:devkit/core/utils/safe_call.dart';
import 'package:devkit/features/home/application/devkit_dashboard_cubit.dart';
import 'package:devkit/features/permissions/presentation/screens/permissions_setup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeaderWidget extends StatefulWidget {
  const new({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  late final Future<Result<DeviceInfoData>> _deviceInfoFuture;

  @override
  void initState() {
    super.initState();
    _deviceInfoFuture = DeviceInfoService.getDeviceInfo();
  }

  Future<void> _onOpenPermissions(BuildContext context) async {
    final cubit = context.read<DevKitDashboardCubit>();
    await PermissionsSetupScreen.show(context);
    if (context.mounted) {
      await cubit.checkPermissions();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<DevKitDashboardCubit>();
    final isAdbGranted = cubit.state.consoleState.isAdbGrantMode;

    return FutureBuilder<Result<DeviceInfoData>>(
      future: _deviceInfoFuture,
      builder: (context, snapshot) {
        final data = snapshot.data?.data ?? DeviceInfoData.fallback;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'DEV',
                      style: context.headlineMedium.copyWith(
                        color: Colors.white,
                        fontWeight: .w900,
                        letterSpacing: -1,
                      ),
                    ),
                    Text(
                      'KIT',
                      style: context.headlineMedium.copyWith(
                        color: AppColors.cyanBright,
                        fontWeight: .w900,
                        shadows: const [
                          Shadow(color: AppColors.cyanBright, blurRadius: 10),
                        ],
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () => _onOpenPermissions(context),
                  borderRadius: .circular(6),
                  child: Container(
                    padding: const .symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: isAdbGranted
                          ? AppColors.cyanBright.withValues(alpha: 0.15)
                          : AppColors.cyberAmber.withValues(alpha: 0.15),
                      borderRadius: .circular(4),
                      border: Border.all(
                        color: isAdbGranted
                            ? AppColors.cyanBright.withValues(alpha: 0.8)
                            : AppColors.cyberAmber.withValues(alpha: 0.8),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isAdbGranted
                              ? AppColors.cyanBright.withValues(alpha: 0.3)
                              : AppColors.cyberAmber.withValues(alpha: 0.3),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: .min,
                      spacing: 4,
                      children: [
                        Text(
                          isAdbGranted ? '⚡ ' : '⚠ ',
                          style: context.bodySmall.copyWith(
                            color: isAdbGranted
                                ? AppColors.cyanBright
                                : AppColors.cyberAmber,
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          isAdbGranted ? 'ADB GRANTED' : 'SETUP REQUIRED',
                          style: context.labelSmall.copyWith(
                            color: isAdbGranted
                                ? AppColors.cyanBright
                                : AppColors.cyberAmber,
                            fontSize: 10,
                            fontWeight: .bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  data.brand.toUpperCase(),
                  style: context.labelSmall.copyWith(
                    color: Colors.white70,
                    fontSize: 11,
                    fontWeight: .bold,
                  ),
                ),
                Text(
                  ' • ',
                  style: context.labelSmall.copyWith(
                    color: AppColors.cyberMuted,
                    fontSize: 11,
                  ),
                ),
                Text(
                  data.model.toUpperCase(),
                  style: context.labelSmall.copyWith(
                    color: Colors.white70,
                    fontSize: 11,
                    fontWeight: .bold,
                  ),
                ),
                Text(
                  ' • ',
                  style: context.labelSmall.copyWith(
                    color: AppColors.cyberMuted,
                    fontSize: 11,
                  ),
                ),
                Text(
                  'SDK ${data.sdkVersion}',
                  style: context.labelSmall.copyWith(
                    color: Colors.white70,
                    fontSize: 11,
                    fontWeight: .bold,
                  ),
                ),
                Text(
                  ' • ',
                  style: context.labelSmall.copyWith(
                    color: AppColors.cyberMuted,
                    fontSize: 11,
                  ),
                ),
                Text(
                  data.ipAddress,
                  style: context.labelSmall.copyWith(
                    color: AppColors.primaryBlue,
                    fontSize: 11,
                    fontWeight: .bold,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
