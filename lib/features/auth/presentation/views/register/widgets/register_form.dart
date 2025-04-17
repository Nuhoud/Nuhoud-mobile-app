import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/app_constats.dart';
import 'package:nuhoud/core/utils/app_localizations.dart';

import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/utils/validation.dart';

import '../../../../../../core/widgets/custom_text_filed.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
    required GlobalKey<FormState> registerFormKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  }) : _registerFormKey = registerFormKey;

  final GlobalKey<FormState> _registerFormKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

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
                style: Styles.textStyle20
                    .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
            CustomTextField(
              text: "first_name".tr(context),
              isPassword: false,
              prefixIcon: Icons.person_outline_rounded,
              validatorFun: (p0) =>
                  Validator.validate(p0, ValidationState.normal),
              controller: nameController,
            ),
            CustomTextField(
              text: "email".tr(context),
              prefixIcon: Icons.mail_outline_rounded,
              isPassword: false,
              validatorFun: (p0) =>
                  Validator.validate(p0, ValidationState.email),
              controller: emailController,
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
