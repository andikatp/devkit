import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:devkit/features/home/application/devkit_dashboard_cubit.dart';
import 'package:devkit/features/home/domain/entities/console_state_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PingStatusCardWidget extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final consoleState =
        context.select<DevKitDashboardCubit, ConsoleStateEntity>(
      (c) => c.state.consoleState,
    );
    const host = 'google.com (8.8.8.8)';

    return Container(
      width: double.infinity,
      padding: const .all(12),
      decoration: BoxDecoration(
        color: AppColors.cyberCardAlt.withValues(alpha: 0.9),
        borderRadius: .circular(8),
        border: .all(color: AppColors.cyberAmber.withValues(alpha: 0.6)),
        boxShadow: [
          BoxShadow(
            color: AppColors.cyberAmber.withValues(alpha: 0.15),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 8,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Row(
                spacing: 6,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      shape: .circle,
                      color: AppColors.cyberEmerald,
                      boxShadow: [
                        BoxShadow(color: AppColors.cyberEmerald, blurRadius: 6),
                      ],
                    ),
                  ),
                  Text(
                    'PING STREAM ACTIVE',
                    style: context.labelSmall.copyWith(
                      color: AppColors.cyberEmerald,
                      fontSize: 10,
                      fontFamily: 'monospace',
                      fontWeight: .bold,
                    ),
                  ),
                ],
              ),
              Text(
                'ICMP ECHO ACK',
                style: context.labelSmall.copyWith(
                  color: AppColors.cyberMuted,
                  fontSize: 9,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                'HOST: $host',
                style: context.bodySmall.copyWith(
                  color: Colors.white,
                  fontSize: 11,
                  fontFamily: 'monospace',
                  fontWeight: .bold,
                ),
              ),
              Text(
                'RTT: ${consoleState.rttMs.toStringAsFixed(1)}ms',
                style: context.bodySmall.copyWith(
                  color: AppColors.cyanBright,
                  fontSize: 11,
                  fontFamily: 'monospace',
                  fontWeight: .bold,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                'PACKETS: ${consoleState.packetsSent} SENT / '
                '${consoleState.packetsReceived} RECV',
                style: context.labelSmall.copyWith(
                  color: AppColors.cyberMuted,
                  fontSize: 10,
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                '${consoleState.packetLossPercent.toStringAsFixed(0)}% LOSS',
                style: context.labelSmall.copyWith(
                  color: consoleState.packetLossPercent == 0
                      ? AppColors.cyberEmerald
                      : AppColors.cyberRed,
                  fontSize: 10,
                  fontFamily: 'monospace',
                  fontWeight: .bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
