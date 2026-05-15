import 'package:flutter/material.dart';
import '../../core/savelo_colors.dart';

class SProgressBar extends StatelessWidget {
  final double percentage; // 0.0 to 1.0
  final Color activeColor;
  final Color backgroundColor;

  const SProgressBar({
    super.key,
    required this.percentage,
    this.activeColor = SColors.sdarkgreen,
    this.backgroundColor = const Color(0xFFE0E0E0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: percentage.clamp(0.0, 1.0),
        child: Container(
          decoration: BoxDecoration(
            color: activeColor,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
