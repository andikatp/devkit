import 'package:devkit/features/tools/application/tools_state.dart';
import 'package:devkit/features/tools/domain/repositories/tools_repository.dart';
import 'package:devkit/features/tools/infrastructure/datasources/tools_local_data_source.dart';

class ToolsRepositoryImpl implements ToolsRepository {
  const new({required this.localDataSource});

  final ToolsLocalDataSource localDataSource;

  @override
  Future<ToolsState> getInitialToolsState() {
    return localDataSource.getToolsState();
  }
}
