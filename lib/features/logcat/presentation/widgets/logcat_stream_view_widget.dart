import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:devkit/features/logcat/application/logcat_cubit.dart';
import 'package:devkit/features/logcat/domain/entities/logcat_log_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogcatStreamViewWidget extends StatelessWidget {
  const new({super.key});

  Color _getLogLevelColor(LogLevel level) {
    switch (level) {
      case LogLevel.verbose:
        return AppColors.cyberMuted;
      case LogLevel.debug:
        return AppColors.cyanBright;
      case LogLevel.info:
        return AppColors.cyberEmerald;
      case LogLevel.warn:
        return AppColors.cyberAmber;
      case LogLevel.error:
        return AppColors.cyberRed;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredLogs = context.watch<LogcatCubit>().state.filteredLogs;

    return Container(
      padding: const .all(10),
      decoration: BoxDecoration(
        color: AppColors.cyberBlack.withValues(alpha: 0.75),
        borderRadius: .circular(8),
        border: .all(color: AppColors.cyberBorder.withValues(alpha: 0.5)),
      ),
      child: ListView.builder(
        itemCount: filteredLogs.length,
        itemBuilder: (context, index) {
          final log = filteredLogs[index];
          final color = _getLogLevelColor(log.level);
          return Padding(
            padding: const .symmetric(vertical: 3),
            child: Text(
              log.fullText,
              style: context.bodySmall.copyWith(
                color: color,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          );
        },
      ),
    );
  }
}
