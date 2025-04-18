import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/app_localizations.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/styles.dart';

class VerificationMsg extends StatelessWidget {
  const VerificationMsg({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text.rich(
            TextSpan(
              text: "pleas_enter_the_number".tr(context),
              style: theme.textTheme.bodyLarge?.copyWith(
                color: AppColors.textColor,
              ),
              children: [
                TextSpan(
                  text: email,
                  style: Styles.textStyle15.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColor,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
        ],
      ),
    );
  }
}
