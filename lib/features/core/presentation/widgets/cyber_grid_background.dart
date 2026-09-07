import 'package:devkit/core/constant/app_assets.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CyberGridBackground extends StatelessWidget {
  const new({required this.child, super.key});

  final Widget child;

  static const ColorFilter _neonGridMatrix = ColorFilter.matrix(<double>[
    -1,
    0,
    0,
    0,
    0,
    0,
    -1,
    0,
    0,
    190,
    0,
    0,
    -1,
    0,
    255,
    0,
    0,
    0,
    1,
    0,
  ]);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Container(color: AppColors.cyberBlack)),
        Positioned.fill(
          child: Opacity(
            opacity: 0.22,
            child: ColorFiltered(
              colorFilter: _neonGridMatrix,
              child: Image.asset(AppAssets.grid, repeat: .repeat),
            ),
          ),
        ),
        Positioned.fill(child: child),
      ],
    );
  }
}
