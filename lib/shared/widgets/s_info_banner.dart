import 'package:flutter/material.dart';

class SInfoBanner extends StatelessWidget {
  final Widget icon;
  final String text;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Widget? trailing;

  const SInfoBanner({
    super.key,
    required this.icon,
    required this.text,
    required this.backgroundColor,
    this.borderColor = Colors.transparent,
    this.textColor = Colors.black87,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon,
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: textColor, height: 1.4, fontSize: 13),
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: 8),
            trailing!,
          ]
        ],
      ),
    );
  }
}
