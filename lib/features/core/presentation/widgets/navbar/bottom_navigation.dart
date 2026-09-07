import 'package:devkit/core/theme/app_theme.dart';
import 'package:devkit/features/core/presentation/widgets/navbar/devkit_nav_item.dart';
import 'package:flutter/material.dart';

class DevKitBottomNavigationBar extends StatelessWidget {
  const new({
    required this.currentIndex,
    required this.onTap,
    required this.isPro,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool isPro;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cyberDark,
        border: const Border(top: BorderSide(color: AppColors.cyberBorder)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 10),
        ],
      ),
      child: Row(
        mainAxisAlignment: .spaceAround,
        children: [
          DevKitNavItem(
            index: 0,
            icon: Icons.grid_view,
            label: 'HOME',
            isActive: currentIndex == 0,
            onTap: () => onTap(0),
          ),
          DevKitNavItem(
            index: 1,
            icon: Icons.terminal,
            label: 'LOGCAT',
            isActive: currentIndex == 1,
            onTap: () => onTap(1),
          ),
          DevKitNavItem(
            index: 2,
            icon: Icons.construction,
            label: 'TOOLS',
            isPro: true,
            isProUnlocked: isPro,
            isActive: currentIndex == 2,
            onTap: () => onTap(2),
          ),
        ],
      ),
    );
  }
}
