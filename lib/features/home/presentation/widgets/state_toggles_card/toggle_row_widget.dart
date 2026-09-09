import 'package:devkit/features/tools/presentation/widgets/tool_switch_card.dart';
import 'package:flutter/material.dart';

class ToggleRowWidget extends StatelessWidget {
  const new({
    required this.title,
    required this.icon,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final String title;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return ToolSwitchCard(
      title: title,
      subtitle: value ? 'On' : 'Off',
      icon: icon,
      value: value,
      onChanged: onChanged,
      hasCardDecoration: false,
    );
  }
}
