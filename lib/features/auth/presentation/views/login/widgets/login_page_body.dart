import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/app_localizations.dart';
import 'package:nuhoud/core/widgets/gradient_container.dart';

import '../../../../../../core/utils/app_constats.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/utils/styles.dart';
import '../../widgets/app_logo_image.dart';
import '../../../../../../core/widgets/custom_button.dart';
import 'login_form.dart';
import 'singin_forget_password.dart';

class LoginPageBody extends StatefulWidget {
  const LoginPageBody({super.key});
  @override
  State<LoginPageBody> createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<LoginPageBody> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _phoneController;
  AuthType selectedAuthType = AuthType.phone;
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _phoneController = TextEditingController();
    super.initState();
  }

  void _handleAuthTypeChanged(AuthType newType) {
    setState(() {
      selectedAuthType = newType;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: ListView(
        padding: const EdgeInsets.symmetric(
            horizontal: kHorizontalPadding, vertical: kVerticalPadding),
        children: [
          const AppLogoImage(),
          LoginForm(
              onAuthTypeChanged: _handleAuthTypeChanged,
              phoneController: _phoneController,
              selectedAuthType: selectedAuthType,
              loginFormKey: _loginFormKey,
              emailController: _emailController,
              passwordController: _passwordController),
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
