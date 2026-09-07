import 'package:devkit/features/tools/application/tools_state.dart';

abstract class ToolsRepository {
  Future<ToolsState> getInitialToolsState();
}
