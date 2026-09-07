import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/services/device_info_service.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatefulWidget {
  const new({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  late final Future<DeviceInfoData> _deviceInfoFuture;
  bool _isAdbGranted = true;

  @override
  void initState() {
    super.initState();
    _deviceInfoFuture = DeviceInfoService.getDeviceInfo();
  }

  void _onToggleGrantMode() {
    setState(() => _isAdbGranted = !_isAdbGranted);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DeviceInfoData>(
      future: _deviceInfoFuture,
      builder: (context, snapshot) {
        final data = snapshot.data ?? DeviceInfoData.fallback;
        return Column(
          crossAxisAlignment: .start,
          spacing: 8,
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
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
                  onTap: _onToggleGrantMode,
                  borderRadius: .circular(6),
                  child: Container(
                    padding: const .symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _isAdbGranted
                          ? AppColors.cyanBright.withValues(alpha: 0.15)
                          : AppColors.cyberCardAlt,
                      borderRadius: .circular(4),
                      border: Border.all(
                        color: _isAdbGranted
                            ? AppColors.cyanBright.withValues(alpha: 0.8)
                            : AppColors.cyberBorder,
                      ),
                      boxShadow: _isAdbGranted
                          ? [
                              BoxShadow(
                                color: AppColors.cyanBright.withValues(
                                  alpha: 0.3,
                                ),
                                blurRadius: 8,
                              ),
                            ]
                          : null,
                    ),
                    child: Row(
                      mainAxisSize: .min,
                      children: [
                        Text(
                          '⚡ ',
                          style: context.bodySmall.copyWith(
                            color: _isAdbGranted
                                ? AppColors.cyanBright
                                : AppColors.cyberMuted,
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          _isAdbGranted ? 'ADB GRANTED' : 'ADB REQUIRED',
                          style: context.labelSmall.copyWith(
                            color: _isAdbGranted
                                ? AppColors.cyanBright
                                : AppColors.cyberMuted,
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
