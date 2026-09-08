import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:devkit/features/logcat/application/logcat_cubit.dart';
import 'package:devkit/features/logcat/domain/entities/logcat_log_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogcatLevelFilterWidget extends StatelessWidget {
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

  void _onSelectLevel(BuildContext context, LogLevel lvl) {
    context.read<LogcatCubit>().selectLogLevel(level: lvl);
  }

  @override
  Widget build(BuildContext context) {
    final selectedLevel = context.watch<LogcatCubit>().state.selectedLevel;

    return SingleChildScrollView(
      scrollDirection: .horizontal,
      child: Row(
        children: LogLevel.values.map((lvl) {
          final isSelected = selectedLevel == lvl;
          final color = _getLogLevelColor(lvl);
          return Padding(
            padding: const .only(right: 6),
            child: ChoiceChip(
              label: Text(
                lvl.name.toUpperCase(),
                style: context.labelSmall.copyWith(
                  fontSize: 10,
                  fontFamily: 'monospace',
                  fontWeight: .bold,
                  color: isSelected ? Colors.white : color,
                ),
              ),
              selected: isSelected,
              selectedColor: color.withValues(alpha: 0.3),
              backgroundColor: AppColors.cyberCardAlt,
              shape: RoundedRectangleBorder(
                borderRadius: .circular(4),
                side: BorderSide(
                  color: isSelected ? color : AppColors.cyberBorder,
                ),
              ),
              onSelected: (val) {
                if (val) {
                  _onSelectLevel(context, lvl);
                }
              },
              visualDensity: .compact,
            ),
          );
        }).toList(),
      ),
    );
  }
}
