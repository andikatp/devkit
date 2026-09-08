import 'dart:async';

import 'package:devkit/core/theme/app_theme.dart';
import 'package:devkit/features/permissions/application/permissions_cubit.dart';
import 'package:devkit/features/permissions/application/permissions_state.dart';
import 'package:devkit/features/permissions/presentation/widgets/basic_permissions_step.dart';
import 'package:devkit/features/permissions/presentation/widgets/direct_mode_step.dart';
import 'package:devkit/features/permissions/presentation/widgets/permissions_bottom_bar.dart';
import 'package:devkit/features/permissions/presentation/widgets/permissions_header_bar.dart';
import 'package:devkit/features/permissions/presentation/widgets/skip_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PermissionsSetupScreen extends StatefulWidget {
  const new({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider(
        create: (_) => PermissionsCubit(),
        child: const PermissionsSetupScreen(),
      ),
    );
  }

  @override
  State<PermissionsSetupScreen> createState() =>
      _PermissionsSetupScreenState();
}

class _PermissionsSetupScreenState extends State<PermissionsSetupScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _handleSkip(BuildContext context) async {
    final proceed = await SkipConfirmationDialog.show(context);
    if (proceed == true && context.mounted) {
      Navigator.of(context).pop();
    }
  }

  void _onBack(BuildContext context, int currentStep) {
    if (currentStep > 1) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  void _goToStep(BuildContext context, int step) {
    context.read<PermissionsCubit>().setStep(step);
    _pageController.animateToPage(
      step - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final cubit = context.watch<PermissionsCubit>();
    final state = cubit.state;

    return BlocListener<PermissionsCubit, PermissionsState>(
      listenWhen: (prev, curr) => prev.currentStep != curr.currentStep,
      listener: (context, state) {
        if (_pageController.hasClients &&
            _pageController.page?.round() != state.currentStep - 1) {
          _pageController.animateToPage(
            state.currentStep - 1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      },
      child: Container(
        height: mediaQuery.size.height * 0.9,
        decoration: const BoxDecoration(
          color: AppColors.cyberBlack,
          borderRadius: .vertical(top: .circular(24)),
          border: Border(top: BorderSide(color: AppColors.cyberBorder)),
        ),
        padding: const .fromLTRB(20, 20, 20, 24),
        child: Column(
          spacing: 16,
          children: [
            PermissionsHeaderBar(
              currentStep: state.currentStep,
              totalSteps: 2,
              onBack: () => _onBack(context, state.currentStep),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  cubit.setStep(index + 1);
                },
                children: const [
                  BasicPermissionsStep(),
                  DirectModeStep(),
                ],
              ),
            ),
            PermissionsBottomBar(
              currentStep: state.currentStep,
              isDirectModeGranted: state.isDirectModeGranted,
              onContinue: () => _goToStep(context, 2),
              onFinish: () => Navigator.of(context).pop(),
              onSkip: () => unawaited(_handleSkip(context)),
            ),
          ],
        ),
      ),
    );
  }
}
