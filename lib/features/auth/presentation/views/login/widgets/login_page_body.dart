import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuhoud/core/utils/app_localizations.dart';
import 'package:nuhoud/core/utils/services_locater.dart';
import 'package:nuhoud/core/widgets/gradient_container.dart';
import 'package:nuhoud/features/auth/presentation/view-model/auth_cubit.dart';

import '../../../../../../core/utils/app_constats.dart';
import '../../../../../../core/utils/enums.dart';
import '../../widgets/app_logo_image.dart';
import '../../widgets/auth_bloc_consumer.dart';
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
          AuthBlocConsumer(
            cubit: getit.get<AuthCubit>(),
            buttonText: "login".tr(context),
            onPressed: () {
              if (_loginFormKey.currentState!.validate()) {
                final emailOrPhone = selectedAuthType == AuthType.email
                    ? _emailController.text
                    : _phoneController.text;
                context.read<AuthCubit>().login(
                    emailOrPhone: emailOrPhone,
                    password: _passwordController.text,
                    authType: selectedAuthType);
              }
            },
            onSuccess: () {},
          )
        ],
      ),
    );
  }
}
