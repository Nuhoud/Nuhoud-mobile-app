import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_constats.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.onPressed,
      this.verticalHieght,
      this.horizontalWidth,
      this.height,
      required this.child});

  final void Function() onPressed;
  final double? verticalHieght;
  final double? horizontalWidth;
  final double? height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: verticalHieght ?? kVerticalPadding,
        horizontal: horizontalWidth ?? kHorizontalPadding,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kBorderRadius),
          gradient: const LinearGradient(
            colors: [
              AppColors.primaryColor,
              AppColors.blueLighterColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: MaterialButton(
          elevation: 0,
          height: height ?? 50,
          minWidth: double.infinity,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          onPressed: onPressed,
          child: AnimatedScale(
            duration: const Duration(milliseconds: 200),
            scale: 0.95,
            child: child,
          ),
        ),
      ),
    );
  }
}
