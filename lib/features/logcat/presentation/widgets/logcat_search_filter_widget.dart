import 'dart:async';

import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:devkit/features/logcat/application/logcat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogcatSearchFilterWidget extends StatefulWidget {
  const new({super.key});

  @override
  State<LogcatSearchFilterWidget> createState() =>
      _LogcatSearchFilterWidgetState();
}

class _LogcatSearchFilterWidgetState extends State<LogcatSearchFilterWidget> {
  late final TextEditingController _filterController;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _filterController = TextEditingController();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _filterController.dispose();
    super.dispose();
  }

  void _onSearchChanged(BuildContext context, String val) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 150), () {
      if (mounted) {
        context.read<LogcatCubit>().updateFilter(query: val);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.cyberCardAlt.withValues(alpha: 0.85),
        borderRadius: .circular(6),
        border: .all(color: AppColors.cyberBorder),
      ),
      child: Row(
        spacing: 8,
        children: [
          const Icon(Icons.search, color: AppColors.cyberMuted, size: 16),
          Expanded(
            child: TextField(
              controller: _filterController,
              onChanged: (val) => _onSearchChanged(context, val),
              style: context.bodySmall.copyWith(
                color: AppColors.cyanBright,
                fontSize: 12,
                fontFamily: 'monospace',
              ),
              decoration: InputDecoration(
                border: .none,
                isDense: true,
                contentPadding: const .symmetric(vertical: 6),
                hintText: 'Filter tag, package, or regex...',
                hintStyle: context.bodySmall.copyWith(
                  color: AppColors.cyberMuted,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
