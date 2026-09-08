import 'dart:async';

import 'package:devkit/core/services/secure_storage_service.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:devkit/features/core/presentation/widgets/cyber_grid_background.dart';
import 'package:devkit/features/permissions/application/permissions_cubit.dart';
import 'package:devkit/features/permissions/application/permissions_state.dart';
import 'package:devkit/features/permissions/presentation/widgets/basic_permissions_step.dart';
import 'package:devkit/features/permissions/presentation/widgets/direct_mode_step.dart';
import 'package:devkit/features/permissions/presentation/widgets/permissions_bottom_bar.dart';
import 'package:devkit/features/permissions/presentation/widgets/permissions_header_bar.dart';
import 'package:devkit/features/permissions/presentation/widgets/skip_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PermissionsSetupPage extends StatefulWidget {
  const new({required this.onCompleted, super.key});
  final VoidCallback onCompleted;

  @override
  State<PermissionsSetupPage> createState() => _PermissionsSetupPageState();
}

class _PermissionsSetupPageState extends State<PermissionsSetupPage> {
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

  Future<void> _handleFinish(BuildContext context) async {
    await SecureStorageService.markPermissionsSetupSeen();
    widget.onCompleted();
  }

  Future<void> _handleSkip(BuildContext context) async {
    final proceed = await SkipConfirmationDialog.show(context);
    if (proceed == true && context.mounted) {
      await _handleFinish(context);
    }
  }

  void _onBack(BuildContext context, int currentStep) {
    if (currentStep > 1) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      unawaited(_handleFinish(context));
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
    return BlocProvider(
      create: (_) => PermissionsCubit(),
      child: Builder(
        builder: (context) {
          final cubit = context.watch<PermissionsCubit>();
          final state = cubit.state;

          return BlocListener<PermissionsCubit, PermissionsState>(
            listenWhen: (prev, curr) =>
                prev.currentStep != curr.currentStep ||
                (!prev.isDirectModeGranted && curr.isDirectModeGranted),
            listener: (context, state) {
              if (_pageController.hasClients &&
                  _pageController.page?.round() != state.currentStep - 1) {
                _pageController.animateToPage(
                  state.currentStep - 1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
              if (state.isDirectModeGranted && state.currentStep == 2) {
                Future.delayed(const Duration(milliseconds: 600), () {
                  if (context.mounted) {
                    unawaited(_handleFinish(context));
                  }
                });
              }
            },
            child: Scaffold(
              backgroundColor: AppColors.cyberBlack,
              body: CyberGridBackground(
                child: SafeArea(
                  child: Padding(
                    padding: const .fromLTRB(20, 16, 20, 16),
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
                          onFinish: () => unawaited(_handleFinish(context)),
                          onSkip: () => unawaited(_handleSkip(context)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
