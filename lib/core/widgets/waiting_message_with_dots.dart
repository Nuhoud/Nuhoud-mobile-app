import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/app_colors.dart';
import 'package:nuhoud/core/utils/styles.dart';
import 'package:nuhoud/core/widgets/app_animated_dots.dart';

class WaitingMessageWithDots extends StatelessWidget {
  final String message;
  const WaitingMessageWithDots({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
          textAlign: TextAlign.center,
          style: Styles.textStyle16.copyWith(color: AppColors.headingTextColor),
        ),
        const SizedBox(height: 12),
        const AppAnimatedDots(size: 30),
      ],
    );
  }
}
