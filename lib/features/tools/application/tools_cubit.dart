import 'package:devkit/features/tools/application/tools_state.dart';
import 'package:devkit/features/tools/domain/repositories/tools_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToolsCubit extends Cubit<ToolsState> {
  new({
    required this.toolsRepository,
    ToolsState? initialState,
  }) : super(initialState ?? const .new());

  final ToolsRepository toolsRepository;

  void toggleLayoutBounds({required bool value}) {
    emit(state.copyWith(showLayoutBounds: value));
  }

  void toggleTaps({required bool value}) {
    emit(state.copyWith(showTaps: value));
  }

  void togglePointerLocation({required bool value}) {
    emit(state.copyWith(showPointerLocation: value));
  }

  void toggleGpuProfiling({required bool value}) {
    emit(state.copyWith(gpuProfiling: value));
  }

  void toggleStrictMode({required bool value}) {
    emit(state.copyWith(strictMode: value));
  }

  void setAnimationScale({required double scale}) {
    emit(state.copyWith(animationScale: scale));
  }
}
