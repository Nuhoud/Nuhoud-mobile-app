import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuhoud/core/utils/app_localizations.dart';
import 'package:nuhoud/core/widgets/custom_app_bar.dart';

import '../../../../../../core/utils/app_constats.dart';

import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/utils/services_locater.dart';
import '../../../../../../core/widgets/gradient_container.dart';
import '../../../view-model/auth_cubit.dart';
import '../../widgets/app_logo_image.dart';
import '../../widgets/auth_bloc_consumer.dart';
import 'register_form.dart';

class RegisterPageBody extends StatefulWidget {
  const RegisterPageBody({super.key});
  @override
  State<RegisterPageBody> createState() => _RegisterPageBodyState();
}

class _RegisterPageBodyState extends State<RegisterPageBody> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final TextEditingController phoneController;
  AuthType selectedAuthType = AuthType.phone;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    phoneController = TextEditingController();
  }

  void _handleAuthTypeChanged(AuthType newType) {
    setState(() {
      selectedAuthType = newType;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Column(
        children: [
          SafeArea(
              child: CustomAppBar(title: "sing_up".tr(context), backBtn: true)),
          Expanded(
            child: ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              children: [
                const AppLogoImage(),
                RegisterForm(
                  registerFormKey: _registerFormKey,
                  nameController: nameController,
                  selectedAuthType: selectedAuthType,
                  onAuthTypeChanged: _handleAuthTypeChanged,
                  phoneController: phoneController,
                  emailController: emailController,
                  passwordController: passwordController,
                  confirmPasswordController: confirmPasswordController,
                ),
                AuthBlocConsumer(
                  cubit: getit.get<AuthCubit>(),
                  buttonText: "confirm".tr(context),
                  onPressed: () {
                    if (_registerFormKey.currentState!.validate()) {
                      final emailOrPhone = selectedAuthType == AuthType.email
                          ? emailController.text
                          : phoneController.text;
                      context.read<AuthCubit>().register(
                          name: nameController.text,
                          emailOrPhone: emailOrPhone,
                          password: passwordController.text,
                          authType: selectedAuthType);
                    }
                  },
                  onSuccess: () {},
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
