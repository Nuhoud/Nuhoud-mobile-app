import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/app_localizations.dart';

import '../../../../../../core/utils/app_constats.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/utils/validation.dart';
import '../../../../../../core/widgets/custom_text_filed.dart';
import '../../widgets/custom_segmented_button.dart';
import '../../widgets/email_phone_text_field.dart';

class RestPasswordForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;
  final AuthType selectedAuthType;
  final ValueChanged<AuthType> onAuthTypeChanged;
  final TextEditingController phoneController;
  const RestPasswordForm(
      {super.key,
      required this.emailController,
      required this.passwordController,
      required this.confirmPasswordController,
      required this.formKey,
      required this.selectedAuthType,
      required this.onAuthTypeChanged,
      required this.phoneController});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: kVerticalPadding),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CustomSegmentedButton(
              onAuthTypeChanged: onAuthTypeChanged,
              selectedAuthType: selectedAuthType,
            ),
            EmailPhoneTextField(
                selectedAuthType: selectedAuthType,
                emailController: emailController,
                phoneController: phoneController),
            CustomTextField(
              text: "new_password".tr(context),
              validatorFun: (p0) =>
                  Validator.validate(p0, ValidationState.password),
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
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
          ]),
        ));
  }
}
