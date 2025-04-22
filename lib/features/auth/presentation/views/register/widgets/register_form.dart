import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/app_constats.dart';
import 'package:nuhoud/core/utils/app_localizations.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/utils/validation.dart';

import '../../../../../../core/widgets/custom_text_filed.dart';
import '../../widgets/custom_segmented_button.dart';
import '../../widgets/email_phone_text_field.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
    required GlobalKey<FormState> registerFormKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.selectedAuthType,
    required this.onAuthTypeChanged,
    required this.phoneController,
  }) : _registerFormKey = registerFormKey;

  final GlobalKey<FormState> _registerFormKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final AuthType selectedAuthType;
  final ValueChanged<AuthType> onAuthTypeChanged;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kVerticalPadding),
      child: Form(
        key: _registerFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: Text(
                "sing_up".tr(context),
                style: Styles.textStyle20.copyWith(
                    color: AppColors.primaryColor, fontWeight: FontWeight.w700),
              ),
            ),
            CustomSegmentedButton(
              onAuthTypeChanged: onAuthTypeChanged,
              selectedAuthType: selectedAuthType,
            ),
            EmailPhoneTextField(
                selectedAuthType: selectedAuthType,
                emailController: emailController,
                phoneController: phoneController),
            CustomTextField(
              text: "first_name".tr(context),
              isPassword: false,
              prefixIcon: Icons.person_outline_rounded,
              validatorFun: (p0) =>
                  Validator.validate(p0, ValidationState.normal),
              controller: nameController,
            ),
            CustomTextField(
                text: "password".tr(context),
                prefixIcon: Icons.lock_outline_rounded,
                validatorFun: (p0) =>
                    Validator.validate(p0, ValidationState.password),
                isPassword: true,
                controller: passwordController),
            CustomTextField(
                text: "confirm_password".tr(context),
                isPassword: true,
                prefixIcon: Icons.lock_outline_rounded,
                validatorFun: (p0) => Validator.validateConfirmPassword(
                    p0, passwordController.text),
                controller: confirmPasswordController),
          ],
        ),
      ),
    );
  }
}
