import 'package:flutter/material.dart';
import '../../core/savelo_colors.dart';

class SStepProgress extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const SStepProgress({
    super.key,
    required this.currentStep,
    this.totalSteps = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (index) {
        bool isActive = index < currentStep;

        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: index == totalSteps - 1 ? 0 : 8.0),
            height: 4,
            decoration: BoxDecoration(
              color: isActive ? SColors.sdarkgreen : SColors.sinput,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }
}
