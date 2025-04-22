import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';

class CustomAuthContainer extends StatelessWidget {
  const CustomAuthContainer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: child));
  }
}
