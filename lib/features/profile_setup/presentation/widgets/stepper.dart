import 'package:flutter/material.dart';
import 'package:unigate/core/theme/app_colors.dart';

class StepperWidget extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepperWidget({
    super.key,
    required this.currentStep,
    this.totalSteps = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps * 2 - 1, (index) {
        if (index.isOdd) {
          return Expanded(
            child: Container(
              height: 2,
              color: (index ~/ 2) < currentStep
                  ? Colors.blue
                  : Colors.grey.shade300,
            ),
          );
        } else {
          int stepIndex = index ~/ 2;
          bool isCompleted = stepIndex < currentStep;
          bool isCurrent = stepIndex == currentStep;

          return Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCompleted || isCurrent ? Colors.blue : AppColors.white,
            ),
            child: Center(
              child: isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 20)
                  : Text(
                      "${stepIndex + 1}",
                      style: TextStyle(
                        color: isCurrent ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          );
        }
      }),
    );
  }
}
