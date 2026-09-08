import 'package:devkit/core/di/injection_container.dart';
import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:devkit/features/tools/application/paywall_cubit.dart';
import 'package:devkit/features/tools/presentation/widgets/pro_paywall_sheet/paywall_custom_amount_input.dart';
import 'package:devkit/features/tools/presentation/widgets/pro_paywall_sheet/paywall_tier_option_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProPaywallSheet extends StatefulWidget {
  const new({super.key});

  static Future<bool?> show<T>(BuildContext context) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider(
        create: (_) => sl<PaywallCubit>(),
        child: const ProPaywallSheet(),
      ),
    );
  }

  @override
  State<ProPaywallSheet> createState() => _ProPaywallSheetState();
}

class _ProPaywallSheetState extends State<ProPaywallSheet> {
  late final TextEditingController _customAmountController;
  late final FocusNode _customAmountFocusNode;

  @override
  void initState() {
    super.initState();
    _customAmountController = TextEditingController(text: '10');
    _customAmountFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _customAmountController.dispose();
    _customAmountFocusNode.dispose();
    super.dispose();
  }

  void _onClose() {
    Navigator.of(context).pop(false);
  }

  void _onConfirmDonate(String amountText) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          spacing: 8,
          children: [
            const Icon(
              Icons.check_circle,
              color: AppColors.cyanBright,
              size: 20,
            ),
            Expanded(
              child: Text(
                'Thank you for supporting DevKit Pro ($amountText)! '
                'Pro unlocked.',
                style: context.bodySmall.copyWith(
                  color: Colors.white,
                  fontWeight: .bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.cyberDark,
        behavior: .fixed,
      ),
    );
    Navigator.of(context).pop(true);
  }

  void _onSelectTier(BuildContext context, int index) {
    context.read<PaywallCubit>().selectTier(index: index);
    if (index == 2) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _customAmountFocusNode.requestFocus();
          _customAmountController.selection = TextSelection(
            baseOffset: 0,
            extentOffset: _customAmountController.text.length,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final state = context.watch<PaywallCubit>().state;

    return Padding(
      padding: .only(bottom: bottomInset),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.cyberDark,
          borderRadius: .vertical(top: .circular(16)),
          border: Border(
            top: BorderSide(color: AppColors.cyberAmber, width: 1.5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 16,
              offset: Offset(0, -4),
            ),
          ],
        ),
        padding: const .all(16),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: .min,
              crossAxisAlignment: .start,
              spacing: 10,
              children: [
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Row(
                      spacing: 6,
                      children: [
                        Text(
                          '⚡ ',
                          style: context.bodyMedium.copyWith(
                            color: AppColors.cyberAmber,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'SUPPORT CREATOR & UNLOCK PRO',
                          style: context.titleSmall.copyWith(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: .bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Container(
                          padding: const .symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.cyberAmber.withValues(alpha: 0.2),
                            borderRadius: .circular(4),
                            border: .all(
                              color: AppColors.cyberAmber.withValues(
                                alpha: 0.4,
                              ),
                            ),
                          ),
                          child: Text(
                            'PRO SUITE',
                            style: context.labelSmall.copyWith(
                              color: AppColors.cyberAmber,
                              fontSize: 9,
                              fontWeight: .bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: _onClose,
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.cyberMuted,
                        size: 20,
                      ),
                      visualDensity: .compact,
                    ),
                  ],
                ),
                Text(
                  'DevKit is independently built. Unlock advanced '
                  'developer tools, Layout Bounds inspector, Animation '
                  'Scaler, and Direct ADB toggle engine permanently.',
                  style: context.bodySmall.copyWith(
                    color: AppColors.cyberMuted,
                    fontSize: 11,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 2),
                PaywallTierOptionCard(
                  index: 0,
                  title: r'$1.00 • Buy a Coffee',
                  subtitle: 'Supporter badge & instant Pro access',
                  badgeText: 'LIFETIME',
                  isSelected: state.selectedTier == 0,
                  onTap: () => _onSelectTier(context, 0),
                ),
                PaywallTierOptionCard(
                  index: 1,
                  title: r'$5.00 • Pro License',
                  subtitle:
                      'Unlock all Pro Tools + Direct ADB toggles '
                      'permanently',
                  badgeText: 'LIFETIME',
                  isPopular: true,
                  isSelected: state.selectedTier == 1,
                  onTap: () => _onSelectTier(context, 1),
                ),
                PaywallTierOptionCard(
                  index: 2,
                  title: 'Custom Amount',
                  subtitle: 'Enter any donation amount to support DevKit',
                  badgeText: 'LIFETIME',
                  isSelected: state.selectedTier == 2,
                  onTap: () => _onSelectTier(context, 2),
                ),
                if (state.selectedTier == 2) ...[
                  PaywallCustomAmountInput(
                    controller: _customAmountController,
                    focusNode: _customAmountFocusNode,
                  ),
                ],
                const SizedBox(height: 4),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () =>
                        _onConfirmDonate(state.formattedSelectedPrice),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.cyberAmber,
                      foregroundColor: Colors.black,
                      padding: const .symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: .circular(6)),
                      elevation: 6,
                    ),
                    child: Row(
                      mainAxisAlignment: .center,
                      children: [
                        Text(
                          '⚡ ',
                          style: context.bodyMedium.copyWith(fontSize: 14),
                        ),
                        Text(
                          'DONATE ${state.formattedSelectedPrice} '
                          '& UNLOCK PRO',
                          style: context.labelMedium.copyWith(
                            color: Colors.black,
                            fontWeight: .w900,
                            fontSize: 12,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
