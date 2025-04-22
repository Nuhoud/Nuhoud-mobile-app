import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;
  const GradientContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryColor,
            AppColors.secodaryColor,
            Color(0xffded2f6)
          ],
          stops: [0.1, 0.5, 0.9],
        ),
      ),
      child: child,
    );
  }
}
