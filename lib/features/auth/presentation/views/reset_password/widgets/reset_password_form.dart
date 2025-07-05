import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/app_localizations.dart';

import '../../../../../../core/utils/app_constats.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/utils/validation.dart';
import '../../../../../../core/widgets/custom_text_filed.dart';

class RestPasswordForm extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;
  const RestPasswordForm({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: kVerticalPadding),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CustomTextField(
              text: "new_password".tr(context),
              validatorFun: (p0) => Validator.validate(p0, ValidationState.password),
              isPassword: true,
              prefixIcon: Icons.lock_outline_rounded,
              controller: passwordController,
            ),
            CustomTextField(
              text: "confirm_password".tr(context),
              isPassword: true,
              prefixIcon: Icons.lock_outline_rounded,
              validatorFun: (p0) => Validator.validateConfirmPassword(
                p0,
                passwordController.text,
              ),
              controller: confirmPasswordController,
            ),
          ]),
        ));
  }
}
