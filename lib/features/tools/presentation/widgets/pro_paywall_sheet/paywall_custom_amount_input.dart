import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:devkit/features/tools/application/paywall_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaywallCustomAmountInput extends StatelessWidget {
  const new({
    required this.controller,
    required this.focusNode,
    super.key,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  void _onAmountChanged(BuildContext context, String value) {
    context.read<PaywallCubit>().updateCustomAmount(amount: value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .only(top: 4),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        autofocus: true,
        keyboardType: const .numberWithOptions(decimal: true),
        onChanged: (val) => _onAmountChanged(context, val),
        style: context.bodyMedium.copyWith(
          color: Colors.white,
          fontSize: 13,
          fontWeight: .bold,
        ),
        decoration: InputDecoration(
          prefixText: r'$ ',
          prefixStyle: context.bodyMedium.copyWith(
            color: AppColors.cyanBright,
            fontSize: 13,
            fontWeight: .bold,
          ),
          labelText: 'Custom Donation (USD)',
          labelStyle: context.labelSmall.copyWith(
            color: AppColors.cyberMuted,
            fontSize: 11,
          ),
          filled: true,
          fillColor: AppColors.cyberCardAlt,
          contentPadding: const .symmetric(horizontal: 12, vertical: 10),
          enabledBorder: OutlineInputBorder(
            borderRadius: .circular(6),
            borderSide: const BorderSide(color: AppColors.cyberBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: .circular(6),
            borderSide: const BorderSide(
              color: AppColors.cyanBright,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
