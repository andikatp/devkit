import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:devkit/features/logcat/application/logcat_cubit.dart';
import 'package:devkit/features/logcat/domain/entities/logcat_log_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogcatStreamViewWidget extends StatefulWidget {
  const new({super.key});

  @override
  State<LogcatStreamViewWidget> createState() => _LogcatStreamViewWidgetState();
}

class _LogcatStreamViewWidgetState extends State<LogcatStreamViewWidget>
    with AutomaticKeepAliveClientMixin {
  late final ScrollController _scrollController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottomIfNeeded(bool isAutoScrollEnabled) {
    if (!isAutoScrollEnabled) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients &&
          _scrollController.position.hasContentDimensions) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  Future<void> _onCopyLine(BuildContext context, LogcatLogEntity log) async {
    await context.read<LogcatCubit>().copyLogLine(log);
  }

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
    super.build(context);
    final filteredLogs = context.select<LogcatCubit, List<LogcatLogEntity>>(
      (c) => c.state.filteredLogs,
    );
    final isAutoScrollEnabled =
        context.select<LogcatCubit, bool>((c) => c.state.isAutoScrollEnabled);

    _scrollToBottomIfNeeded(isAutoScrollEnabled);

    return Container(
      padding: const .all(10),
      decoration: BoxDecoration(
        color: AppColors.cyberBlack.withValues(alpha: 0.75),
        borderRadius: .circular(8),
        border: .all(color: AppColors.cyberBorder.withValues(alpha: 0.5)),
      ),
      child: filteredLogs.isEmpty
          ? Center(
              child: Text(
                'No logs match current filter',
                style: context.bodySmall.copyWith(
                  color: AppColors.cyberMuted,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
            )
          : ListView.builder(
              controller: _scrollController,
              itemCount: filteredLogs.length,
              itemBuilder: (context, index) {
                final log = filteredLogs[index];
                final color = _getLogLevelColor(log.level);
                return InkWell(
                  onTap: () => _onCopyLine(context, log),
                  borderRadius: .circular(4),
                  child: Padding(
                    padding: const .symmetric(vertical: 3, horizontal: 2),
                    child: Text(
                      log.fullText,
                      style: context.bodySmall.copyWith(
                        color: color,
                        fontSize: 11,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
