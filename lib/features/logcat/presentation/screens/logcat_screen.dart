import 'package:devkit/core/theme/app_theme.dart';
import 'package:devkit/features/core/presentation/widgets/header_widget.dart';
import 'package:devkit/features/logcat/application/logcat_cubit.dart';
import 'package:devkit/features/logcat/application/logcat_state.dart';
import 'package:devkit/features/logcat/presentation/widgets/logcat_header_bar_widget.dart';
import 'package:devkit/features/logcat/presentation/widgets/logcat_level_filter_widget.dart';
import 'package:devkit/features/logcat/presentation/widgets/logcat_search_filter_widget.dart';
import 'package:devkit/features/logcat/presentation/widgets/logcat_stream_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogcatScreen extends StatelessWidget {
  const new({super.key});

  void _onStateListener(BuildContext context, LogcatState state) {
    if (state.successMessage != null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            state.successMessage!,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          backgroundColor: AppColors.cyberDark,
          behavior: .fixed,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogcatCubit, LogcatState>(
      listener: _onStateListener,
      child: const Padding(
        padding: .symmetric(horizontal: 16, vertical: 8),
        child: Column(
          spacing: 12,
          children: [
            HeaderWidget(),
            LogcatHeaderBarWidget(),
            LogcatSearchFilterWidget(),
            LogcatLevelFilterWidget(),
            Expanded(
              child: LogcatStreamViewWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
