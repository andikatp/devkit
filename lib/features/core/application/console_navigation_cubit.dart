import 'package:devkit/features/core/application/console_navigation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConsoleNavigationCubit extends Cubit<ConsoleNavigationState> {
  new({ConsoleNavigationState? initialState})
      : super(initialState ?? const .new());

  void selectTab({required int index}) {
    emit(state.copyWith(currentNavIndex: index));
  }

  void unlockPro() {
    emit(state.copyWith(isPro: true, currentNavIndex: 2));
  }
}
