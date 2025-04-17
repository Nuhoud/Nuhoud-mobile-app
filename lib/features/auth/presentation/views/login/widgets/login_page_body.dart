import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/app_localizations.dart';
import 'package:nuhoud/core/widgets/gradient_container.dart';

import 'package:phone_form_field/phone_form_field.dart';

import '../../../../../../core/utils/app_constats.dart';
import '../../../../../../core/utils/assets_data.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/custom_button.dart';
import 'login_form.dart';
import 'singin_forget_password.dart';

class LoginPageBody extends StatefulWidget {
  const LoginPageBody({super.key});
  @override
  State<LoginPageBody> createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<LoginPageBody> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final PhoneController phoneController;
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GradientContainer(
      child: ListView(
        padding: const EdgeInsets.symmetric(
            horizontal: kHorizontalPadding, vertical: kVerticalPadding),
        children: [
          Image.asset(
            AssetsData.logo,
            width: size.width * 0.4,
            height: size.height * 0.4,
          ),
          LoginForm(
              loginFormKey: _loginFormKey,
              emailController: emailController,
              passwordController: passwordController),
          const SignUpForgetPassWidget(),
          CustomButton(
              onPressed: () {
                if (_loginFormKey.currentState!.validate()) {}
              },
              child: Text(
                "login".tr(context),
                style: Styles.textStyle15.copyWith(color: Colors.white),
              )),
        ],
      ),
    );
  }
}
