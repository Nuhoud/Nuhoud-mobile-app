import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_constats.dart';
import '../../../../../../core/utils/styles.dart';

class CustomOptField extends StatelessWidget {
  const CustomOptField({
    super.key,
    this.onSubmit,
  });

  final void Function(String)? onSubmit;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: OtpTextField(
                onSubmit: onSubmit,
                keyboardType: TextInputType.text,
                filled: true,
                fillColor: AppColors.fillTextFiledColor,
                borderColor: AppColors.secondaryText,
                focusedBorderColor: AppColors.secondaryText,
                cursorColor: AppColors.primaryColor,
                fieldWidth: MediaQuery.sizeOf(context).width * 0.15,
                showFieldAsBox: true,
                numberOfFields: 5,
                borderRadius: BorderRadius.circular(kBorderRadius),
                textStyle: Styles.textStyle18.copyWith(color: AppColors.secondaryText),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
        ],
      ),
    );
  }
}
