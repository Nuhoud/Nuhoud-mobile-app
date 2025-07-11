import 'package:flutter/material.dart';
import 'package:nuhoud/core/widgets/custom_circular_progress_indicator.dart';

import '../utils/app_colors.dart';
import '../utils/app_constats.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.onPressed,
      this.verticalHieght,
      this.horizontalWidth,
      this.height,
      required this.child,
      this.primaryGradinetColor,
      this.secodanryGradinetColor,
      this.isLoading});

  final void Function() onPressed;
  final double? verticalHieght;
  final double? horizontalWidth;
  final double? height;
  final bool? isLoading;
  final Widget child;
  final Color? primaryGradinetColor;
  final Color? secodanryGradinetColor;
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
          gradient: LinearGradient(
            colors: [
              primaryGradinetColor ?? AppColors.primaryColor,
              secodanryGradinetColor ?? AppColors.secodaryColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withValues(alpha: 0.3),
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
            child: isLoading == true
                ? const SizedBox(width: 20, height: 20, child: CustomCircularProgressIndicator())
                : child,
          ),
        ),
      ),
    );
  }
}
