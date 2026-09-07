import 'package:devkit/features/tools/application/tools_state.dart';

abstract class ToolsLocalDataSource {
  Future<ToolsState> getToolsState();
}

class ToolsLocalDataSourceImpl implements ToolsLocalDataSource {
  const new();

  @override
  Future<ToolsState> getToolsState() async {
    return const ToolsState();
  }
}
