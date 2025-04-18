import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/app_localizations.dart';

import '../../../../../core/utils/enums.dart';
import '../../../../../core/utils/validation.dart';
import '../../../../../core/widgets/custom_text_filed.dart';

class EmailPhoneTextField extends StatelessWidget {
  final AuthType selectedAuthType;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  const EmailPhoneTextField(
      {super.key,
      required this.selectedAuthType,
      required this.emailController,
      required this.phoneController});
  @override
  Widget build(BuildContext context) {
    return selectedAuthType == AuthType.email
        ? CustomTextField(
            text: "email".tr(context),
            isPassword: false,
            prefixIcon: Icons.mail_outline_rounded,
            validatorFun: (p0) => Validator.validate(p0, ValidationState.email),
            controller: emailController,
          )
        : CustomTextField(
            text: "phone_num".tr(context),
            isPassword: false,
            prefixIcon: Icons.phone_iphone_outlined,
            keyboardType: TextInputType.phone,
            validatorFun: (p0) =>
                Validator.validate(p0, ValidationState.phoneNumber),
            controller: phoneController,
          );
  }
}
