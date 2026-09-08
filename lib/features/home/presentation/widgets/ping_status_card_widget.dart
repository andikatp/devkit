import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PingStatusCardWidget extends StatelessWidget {
  const new({this.targetHost = 'google.com (8.8.8.8)', super.key});

  final String targetHost;

  @override
  Widget build(BuildContext context) {
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
                'HOST: $targetHost',
                style: context.bodySmall.copyWith(
                  color: Colors.white,
                  fontSize: 11,
                  fontFamily: 'monospace',
                  fontWeight: .bold,
                ),
              ),
              Text(
                'RTT: 14.2ms',
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
                'PACKETS: 18 SENT / 18 RECV',
                style: context.labelSmall.copyWith(
                  color: AppColors.cyberMuted,
                  fontSize: 10,
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                '0% LOSS',
                style: context.labelSmall.copyWith(
                  color: AppColors.cyberEmerald,
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
