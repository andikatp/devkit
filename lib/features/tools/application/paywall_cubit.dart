import 'package:devkit/features/tools/application/paywall_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaywallCubit extends Cubit<PaywallState> {
  new({PaywallState? initialState})
      : super(initialState ?? const .new());

  void selectTier({required int index}) {
    emit(state.copyWith(selectedTier: index));
  }

  void updateCustomAmount({required String amount}) {
    emit(state.copyWith(customAmount: amount));
  }
}
