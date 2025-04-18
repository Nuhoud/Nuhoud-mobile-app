import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/app_localizations.dart';
import 'package:nuhoud/core/utils/enums.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/styles.dart';

class VerificationMsg extends StatelessWidget {
  const VerificationMsg(
      {super.key, required this.emailOrPhone, required this.selectedAuthType});
  final AuthType selectedAuthType;
  final String emailOrPhone;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text.rich(
            TextSpan(
              text: selectedAuthType == AuthType.email
                  ? "pleas_enter_the_number_email".tr(context)
                  : "pleas_enter_the_number_phone".tr(context),
              style: theme.textTheme.bodyLarge?.copyWith(
                color: AppColors.textColor,
              ),
              children: [
                TextSpan(
                  text: emailOrPhone,
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
