import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:devkit/features/logcat/application/logcat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogcatHeaderBarWidget extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Row(
          spacing: 4,
          children: [
            Text(
              '>_ ',
              style: context.bodyMedium.copyWith(
                color: AppColors.cyanBright,
                fontFamily: 'monospace',
                fontWeight: .bold,
                fontSize: 16,
              ),
            ),
            Text(
              'LOGCAT STREAM ',
              style: context.titleMedium.copyWith(
                color: Colors.white,
                fontSize: 14,
                fontWeight: .bold,
                letterSpacing: 1,
              ),
            ),
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.cyberEmerald,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cyberEmerald,
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
            Text(
              'LIVE',
              style: context.labelSmall.copyWith(
                color: AppColors.cyberEmerald,
                fontSize: 10,
                fontFamily: 'monospace',
                fontWeight: .bold,
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () => context.read<LogcatCubit>().clearLogs(),
          icon: const Icon(
            Icons.delete_outline,
            color: AppColors.cyberMuted,
            size: 20,
          ),
          tooltip: 'Clear Logs',
        ),
      ],
    );
  }
}
