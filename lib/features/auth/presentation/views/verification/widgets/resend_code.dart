import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/app_localizations.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/styles.dart';

class ResendCode extends StatelessWidget {
  const ResendCode({
    super.key,
    required bool canResend,
    required int remainingTime,
    required this.onPressed,
  })  : _canResend = canResend,
        _remainingTime = remainingTime;

  final bool _canResend;
  final int _remainingTime;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "didn't_receive_code".tr(context),
              style: Styles.textStyle18.copyWith(color: Colors.white),
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: onPressed,
              child: Text(
                _canResend
                    ? "resend".tr(context)
                    : "${"resend".tr(context)} (${_remainingTime.toString().padLeft(2, '0')})",
                style: TextStyle(
                  decoration: _canResend ? TextDecoration.underline : null,
                  decorationColor: _canResend ? AppColors.textColor : null,
                  decorationThickness: _canResend ? 0.6 : null,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
      ],
    );
  }
}
