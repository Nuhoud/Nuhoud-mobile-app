import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';

class OnBoardingContainer extends StatelessWidget {
  const OnBoardingContainer(
      {super.key, required this.child, this.withFixedHight});
  final Widget child;
  final bool? withFixedHight;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          height: (withFixedHight == false && withFixedHight != null)
              ? null
              : MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
