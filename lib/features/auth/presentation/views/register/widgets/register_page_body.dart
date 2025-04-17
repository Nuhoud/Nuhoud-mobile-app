import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nuhoud/core/utils/app_localizations.dart';
import 'package:nuhoud/core/widgets/custom_app_bar.dart';

import '../../../../../../core/utils/app_constats.dart';

import '../../../../../../core/utils/routs.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/gradient_container.dart';
import '../../verification/verification_page.dart';
import '../../widgets/app_logo_image.dart';
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

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
                  emailController: emailController,
                  passwordController: passwordController,
                  confirmPasswordController: confirmPasswordController,
                ),
                CustomButton(
                    child: Text(
                      "confirm".tr(context),
                      style: Styles.textStyle15.copyWith(color: Colors.white),
                    ),
                    onPressed: () {
                      print(emailController.text);
                      GoRouter.of(context).pushReplacement(
                          Routers.kVerificationPageRoute,
                          extra: VerificationArgs(
                              email: emailController.text,
                              isFromRegister: true));
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
