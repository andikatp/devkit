import 'dart:async';

import 'package:devkit/core/extensions/text_theme.dart';
import 'package:devkit/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommandCopyBox extends StatefulWidget {
  const new({
    required this.commandText,
    super.key,
  });

  final String commandText;

  @override
  State<CommandCopyBox> createState() => _CommandCopyBoxState();
}

class _CommandCopyBoxState extends State<CommandCopyBox> {
  bool _copied = false;

  void _onCopy() {
    unawaited(Clipboard.setData(ClipboardData(text: widget.commandText)));
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _copied = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const .all(12),
      decoration: BoxDecoration(
        color: AppColors.cyberBlack.withValues(alpha: 0.9),
        borderRadius: .circular(8),
        border: .all(color: AppColors.cyberBorder),
      ),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 10,
        children: [
          SelectableText(
            widget.commandText,
            style: context.bodySmall.copyWith(
              color: AppColors.cyanBright,
              fontSize: 11,
              fontWeight: .bold,
              fontFamily: 'monospace',
              height: 1.4,
            ),
          ),
          Align(
            alignment: .centerRight,
            child: InkWell(
              onTap: _onCopy,
              borderRadius: .circular(6),
              child: Container(
                padding: const .symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.deepBlue.withValues(alpha: 0.3),
                  borderRadius: .circular(6),
                  border: .all(color: AppColors.cyberBorder),
                ),
                child: Row(
                  mainAxisSize: .min,
                  spacing: 6,
                  children: [
                    Icon(
                      _copied ? Icons.check : Icons.copy,
                      color: _copied
                          ? AppColors.cyanBright
                          : AppColors.primaryBlue,
                      size: 12,
                    ),
                    Text(
                      _copied ? 'COPIED!' : 'Copy Command',
                      style: context.labelSmall.copyWith(
                        color: _copied ? AppColors.cyanBright : Colors.white,
                        fontSize: 11,
                        fontWeight: .bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
