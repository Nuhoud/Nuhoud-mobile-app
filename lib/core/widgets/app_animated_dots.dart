import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nuhoud/core/utils/app_colors.dart';

class AppAnimatedDots extends StatelessWidget {
  final Color? color;
  final double size;

  const AppAnimatedDots({
    super.key,
    this.color,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      color: color ?? AppColors.primaryColor,
      size: size,
    );
  }
}
