import 'dart:async';

import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class WalkthroughSheet extends StatelessWidget {
  const new({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const WalkthroughSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.85,
      ),
      decoration: const BoxDecoration(
        color: AppColors.cyberDark,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        border: Border(top: BorderSide(color: AppColors.cyanBright)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const .all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const .only(bottom: 24),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                'Welcome to DevKit! 🚀',
                style: context.headlineSmall.copyWith(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Your all-in-one Android Developer Dashboard.',
                style: context.bodyMedium.copyWith(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              const Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 24,
                    children: [
                      _FeatureRow(
                        icon: Icons.developer_mode,
                        title: 'Dashboard Toggles',
                        description:
                            'Instantly toggle Developer Options, USB '
                            'Debugging, and Wireless Debugging without leaving '
                            'the app.',
                        color: AppColors.cyanBright,
                      ),
                      _FeatureRow(
                        icon: Icons.terminal,
                        title: 'Real-time Logcat',
                        description:
                            'View, filter, and pause system logs in '
                            'real-time. Catch errors on the fly.',
                        color: AppColors.cyberAmber,
                      ),
                      _FeatureRow(
                        icon: Icons.build_circle_outlined,
                        title: 'Advanced UI Tools (Pro)',
                        description:
                            'Toggle layout bounds, show touches, '
                            'pointer location, and tweak animation scales '
                            'with a single tap.',
                        color: AppColors.primaryBlue,
                      ),
                      _FeatureRow(
                        icon: Icons.star_rate_rounded,
                        title: 'Feedback',
                        description:
                            'Tap the star icon in the header anytime '
                            'to rate the app or share your feedback!',
                        color: Colors.pinkAccent,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.cyanBright,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Let's Go!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const new({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const .all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withValues(alpha: 0.5)),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.titleMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: context.bodyMedium.copyWith(color: Colors.white70),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
