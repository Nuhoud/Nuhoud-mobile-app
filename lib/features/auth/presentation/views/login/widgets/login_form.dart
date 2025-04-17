import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/app_localizations.dart';

import '../../../../../../core/utils/app_constats.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/utils/validation.dart';
import '../../../../../../core/widgets/custom_text_filed.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required GlobalKey<FormState> loginFormKey,
    required this.emailController,
    required this.passwordController,
  }) : _loginFormKey = loginFormKey;

  final GlobalKey<FormState> _loginFormKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Form(
        key: _loginFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: Text(
                "sing_in".tr(context),
                style: Styles.textStyle20
                    .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
            CustomTextField(
                text: "email".tr(context),
                isPassword: false,
                prefixIcon: Icons.mail_outline_rounded,
                validatorFun: (p0) =>
                    Validator.validate(p0, ValidationState.email),
                controller: emailController),
            CustomTextField(
                text: "password".tr(context),
                prefixIcon: Icons.lock_outline_rounded,
                isPassword: true,
                validatorFun: (p0) =>
                    Validator.validate(p0, ValidationState.normal),
                controller: passwordController),
          ],
        ),
      ),
    );
  }
}
