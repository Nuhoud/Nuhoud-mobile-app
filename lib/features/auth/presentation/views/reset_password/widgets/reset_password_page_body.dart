import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/app_localizations.dart';
import 'package:nuhoud/core/widgets/custom_app_bar.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_constats.dart';

import '../../../../../../core/utils/assets_data.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/utils/validation.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/custom_text_filed.dart';
import '../../../../../../core/widgets/gradient_container.dart';

class RestPasswordPageBody extends StatefulWidget {
  const RestPasswordPageBody({super.key});

  @override
  State<RestPasswordPageBody> createState() => _RestPasswordPageBodyState();
}

class _RestPasswordPageBodyState extends State<RestPasswordPageBody> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);

    return GradientContainer(
      child: Column(
        children: [
          SafeArea(
              child: CustomAppBar(
                  title: "rest_password".tr(context), backBtn: true)),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.05, horizontal: kHorizontalPadding),
              children: [
                const ForgetPasswordImage(),
                Text(
                  "enter_phone_num_to_reset_pass".tr(context),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                RestPasswordForm(
                    formKey: _formKey,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    confirmPasswordController: _confirmPasswordController),
                CustomButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                  child: Text(
                    "continue".tr(context),
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RestPasswordForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;
  const RestPasswordForm(
      {super.key,
      required this.emailController,
      required this.passwordController,
      required this.confirmPasswordController,
      required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(children: [
          CustomTextField(
            text: "email".tr(context),
            validatorFun: (p0) => Validator.validate(p0, ValidationState.email),
            isPassword: true,
            controller: passwordController,
          ),
          CustomTextField(
            text: "new_password".tr(context),
            validatorFun: (p0) =>
                Validator.validate(p0, ValidationState.password),
            isPassword: true,
            controller: passwordController,
          ),
          CustomTextField(
            text: "confirm_password".tr(context),
            isPassword: true,
            validatorFun: (p0) => Validator.validateConfirmPassword(
              p0,
              passwordController.text,
            ),
            controller: confirmPasswordController,
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
        ]));
  }
}

class ForgetPasswordImage extends StatelessWidget {
  const ForgetPasswordImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.18,
          alignment: Alignment.center,
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.asset(
              AssetsData.forgetPassword,
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
      ],
    );
  }
}
