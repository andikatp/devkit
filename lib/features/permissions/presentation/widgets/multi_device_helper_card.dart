import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:devkit/features/permissions/presentation/widgets/command_copy_box.dart';
import 'package:flutter/material.dart';

class MultiDeviceHelperCard extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cyberCardAlt,
      shape: RoundedRectangleBorder(
        borderRadius: .circular(10),
        side: const BorderSide(color: AppColors.cyberBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: AppColors.cyberMuted,
          collapsedIconColor: AppColors.cyberMuted,
          leading: const Icon(
            Icons.devices_other,
            color: AppColors.cyberMuted,
            size: 18,
          ),
          title: Text(
            'Multiple devices connected?',
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
                    'If you have emulators or multiple Android devices '
                    'connected, run "adb devices" to find your target device '
                    'ID, then execute:',
                    style: context.bodySmall.copyWith(
                      color: AppColors.cyberMuted,
                      fontSize: 11,
                      height: 1.4,
                    ),
                  ),
                  const CommandCopyBox(
                    commandText:
                        'adb -s <DEVICE_ID> shell pm grant '
                        'com.andikatp.devkit '
                        'android.permission.WRITE_SECURE_SETTINGS',
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
