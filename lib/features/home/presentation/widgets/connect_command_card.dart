import 'dart:async';

import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:devkit/features/home/application/devkit_dashboard_cubit.dart';
import 'package:devkit/features/home/domain/entities/console_state_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glow_container/glow_container.dart';

class ConnectCommandCard extends StatefulWidget {
  const new({super.key});

  @override
  State<ConnectCommandCard> createState() => _ConnectCommandCardState();
}

class _ConnectCommandCardState extends State<ConnectCommandCard> {
  bool _copied = false;

  void _onCopyCommand(String commandText) {
    unawaited(Clipboard.setData(ClipboardData(text: commandText)));
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _copied = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DevKitDashboardCubit>().state.consoleState;
    final commandText = state.adbConnectCommand;

    return Column(
      crossAxisAlignment: .start,
      spacing: 12,
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  '03 ',
                  style: context.labelSmall.copyWith(
                    color: AppColors.primaryBlue,
                    fontWeight: .bold,
                    fontSize: 12,
                  ),
                ),
                Text(
                  'CONNECT',
                  style: context.labelSmall.copyWith(
                    color: AppColors.cyberMuted,
                    fontWeight: .bold,
                    fontSize: 12,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            Container(
              padding: const .symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.cyberCardDeep,
                borderRadius: .circular(4),
                border: Border.all(color: AppColors.cyberBorder),
              ),
              child: Text(
                'MDNS',
                style: context.labelSmall.copyWith(
                  color: AppColors.primaryBlue,
                  fontSize: 10,
                  fontWeight: .bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
        GlowContainer(
          gradientColors: const [
            AppColors.cyanBright,
            AppColors.deepBlue,
            AppColors.primaryBlue,
          ],
          glowRadius: 6,
          rotationDuration: const Duration(seconds: 4),
          containerOptions: const ContainerOptions(
            backgroundColor: AppColors.cyberCard,
            borderRadius: 8,
            borderSide: BorderSide(color: AppColors.cyberBorder),
            padding: EdgeInsets.all(14),
          ),
          child: Column(
            crossAxisAlignment: .start,
            spacing: 8,
            children: [
              Text(
                'RUN THIS ON YOUR COMPUTER',
                style: context.labelSmall.copyWith(
                  color: AppColors.cyberMuted,
                  fontSize: 10,
                  fontWeight: .bold,
                  letterSpacing: 0.5,
                ),
              ),
              Container(
                padding: const .symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.cyberBlack.withValues(alpha: 0.9),
                  borderRadius: .circular(6),
                  border: Border.all(
                    color: AppColors.cyberBorder.withValues(alpha: 0.7),
                  ),
                ),
                child: Row(
                  spacing: 8,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: .horizontal,
                        child: Text(
                          commandText,
                          style: context.bodySmall.copyWith(
                            color: AppColors.cyanBright,
                            fontSize: 11,
                            fontWeight: .bold,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => _onCopyCommand(commandText),
                      borderRadius: .circular(4),
                      child: Container(
                        padding: const .symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.deepBlue.withValues(alpha: 0.3),
                          borderRadius: .circular(4),
                          border: Border.all(
                            color: AppColors.cyberBorder.withValues(alpha: 0.7),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: .min,
                          spacing: 4,
                          children: [
                            Icon(
                              _copied ? Icons.check : Icons.copy,
                              color: _copied
                                  ? AppColors.cyanBright
                                  : AppColors.primaryBlue,
                              size: 12,
                            ),
                            Text(
                              _copied ? 'COPIED!' : 'COPY',
                              style: context.labelSmall.copyWith(
                                color: _copied
                                    ? AppColors.cyanBright
                                    : Colors.white,
                                fontSize: 10,
                                fontWeight: .bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                spacing: 4,
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    color: AppColors.primaryBlue,
                    size: 12,
                  ),
                  Expanded(
                    child: Text(
                      "Port discovered from this device's mDNS advertisement.",
                      style: context.bodySmall.copyWith(
                        color: AppColors.cyberMuted,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
