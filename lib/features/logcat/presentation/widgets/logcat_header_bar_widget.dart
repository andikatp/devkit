import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:devkit/features/logcat/application/logcat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogcatHeaderBarWidget extends StatelessWidget {
  const new({super.key});

  void _onTogglePause(BuildContext context) {
    context.read<LogcatCubit>().togglePause();
  }

  void _onToggleAutoScroll(BuildContext context) {
    context.read<LogcatCubit>().toggleAutoScroll();
  }

  Future<void> _onCopyLogs(BuildContext context) async {
    await context.read<LogcatCubit>().copyLogs();
  }

  void _onClearLogs(BuildContext context) {
    context.read<LogcatCubit>().clearLogs();
  }

  @override
  Widget build(BuildContext context) {
    final isPaused = context.select<LogcatCubit, bool>((c) => c.state.isPaused);
    final isAutoScroll = context.select<LogcatCubit, bool>(
      (c) => c.state.isAutoScrollEnabled,
    );

    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Expanded(
          child: Row(
            mainAxisSize: .min,
            spacing: 4,
            children: [
              Text(
                '>_ ',
                style: context.bodyMedium.copyWith(
                  color: AppColors.cyanBright,
                  fontFamily: 'monospace',
                  fontWeight: .bold,
                  fontSize: 14,
                ),
              ),
              Flexible(
                child: Text(
                  'LOGCAT',
                  overflow: TextOverflow.ellipsis,
                  style: context.titleMedium.copyWith(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: .bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: .circle,
                  color: isPaused
                      ? AppColors.cyberAmber
                      : AppColors.cyberEmerald,
                  boxShadow: [
                    BoxShadow(
                      color: isPaused
                          ? AppColors.cyberAmber
                          : AppColors.cyberEmerald,
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              Text(
                isPaused ? 'PAUSED' : 'LIVE',
                style: context.labelSmall.copyWith(
                  color: isPaused
                      ? AppColors.cyberAmber
                      : AppColors.cyberEmerald,
                  fontSize: 9,
                  fontFamily: 'monospace',
                  fontWeight: .bold,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisSize: .min,
          children: [
            IconButton(
              onPressed: () => _onTogglePause(context),
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              padding: EdgeInsets.zero,
              icon: Icon(
                isPaused ? Icons.play_arrow : Icons.pause,
                color: isPaused ? AppColors.cyberAmber : AppColors.cyanBright,
                size: 18,
              ),
              tooltip: isPaused ? 'Resume Stream' : 'Pause Stream',
            ),
            IconButton(
              onPressed: () => _onToggleAutoScroll(context),
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.arrow_downward,
                color: isAutoScroll
                    ? AppColors.cyanBright
                    : AppColors.cyberMuted,
                size: 18,
              ),
              tooltip: 'Auto-scroll to bottom',
            ),
            IconButton(
              onPressed: () => _onCopyLogs(context),
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.copy,
                color: AppColors.cyberMuted,
                size: 16,
              ),
              tooltip: 'Copy Filtered Logs',
            ),
            IconButton(
              onPressed: () => _onClearLogs(context),
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.delete_outline,
                color: AppColors.cyberMuted,
                size: 18,
              ),
              tooltip: 'Clear Logs',
            ),
          ],
        ),
      ],
    );
  }
}
