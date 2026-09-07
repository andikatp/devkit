import 'package:devkit/features/core/application/console_navigation_cubit.dart';
import 'package:devkit/features/home/application/devkit_dashboard_cubit.dart';
import 'package:devkit/features/home/domain/repositories/home_repository.dart';
import 'package:devkit/features/home/infrastructure/datasources/home_local_data_source.dart';
import 'package:devkit/features/home/infrastructure/repositories/home_repository_impl.dart';
import 'package:devkit/features/logcat/application/logcat_cubit.dart';
import 'package:devkit/features/logcat/domain/repositories/logcat_repository.dart';
import 'package:devkit/features/logcat/infrastructure/datasources/logcat_local_data_source.dart';
import 'package:devkit/features/logcat/infrastructure/repositories/logcat_repository_impl.dart';
import 'package:devkit/features/tools/application/paywall_cubit.dart';
import 'package:devkit/features/tools/application/tools_cubit.dart';
import 'package:devkit/features/tools/domain/repositories/tools_repository.dart';
import 'package:devkit/features/tools/infrastructure/datasources/tools_local_data_source.dart';
import 'package:devkit/features/tools/infrastructure/repositories/tools_repository_impl.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // Datasources
  sl
    ..registerLazySingleton<HomeLocalDataSource>(
      HomeLocalDataSourceImpl.new,
    )
    ..registerLazySingleton<LogcatLocalDataSource>(
      LogcatLocalDataSourceImpl.new,
    )
    ..registerLazySingleton<ToolsLocalDataSource>(
      ToolsLocalDataSourceImpl.new,
    );

  // Repositories
  sl
    ..registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(localDataSource: sl()),
    )
    ..registerLazySingleton<LogcatRepository>(
      () => LogcatRepositoryImpl(localDataSource: sl()),
    )
    ..registerLazySingleton<ToolsRepository>(
      () => ToolsRepositoryImpl(localDataSource: sl()),
    );

  // Cubits / Application Layer
  sl
    ..registerFactory<DevKitDashboardCubit>(
      () => DevKitDashboardCubit(homeRepository: sl()),
    )
    ..registerFactory<LogcatCubit>(
      () => LogcatCubit(logcatRepository: sl()),
    )
    ..registerFactory<ToolsCubit>(
      () => ToolsCubit(toolsRepository: sl()),
    )
    ..registerFactory<PaywallCubit>(
      PaywallCubit.new,
    )
    ..registerFactory<ConsoleNavigationCubit>(
      ConsoleNavigationCubit.new,
    );
}
