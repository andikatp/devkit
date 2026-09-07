import 'package:devkit/core/di/injection_container.dart';
import 'package:devkit/features/core/presentation/widgets/header_widget.dart';
import 'package:devkit/features/logcat/application/logcat_cubit.dart';
import 'package:devkit/features/logcat/presentation/widgets/logcat_header_bar_widget.dart';
import 'package:devkit/features/logcat/presentation/widgets/logcat_level_filter_widget.dart';
import 'package:devkit/features/logcat/presentation/widgets/logcat_search_filter_widget.dart';
import 'package:devkit/features/logcat/presentation/widgets/logcat_stream_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogcatScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LogcatCubit>(),
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
