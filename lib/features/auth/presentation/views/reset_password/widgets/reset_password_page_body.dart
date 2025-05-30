import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/app_localizations.dart';
import 'package:nuhoud/core/utils/styles.dart';
import 'package:nuhoud/core/widgets/custom_app_bar.dart';
import 'package:nuhoud/features/auth/presentation/views/widgets/custom_auth_container.dart';
import 'package:nuhoud/features/auth/presentation/views/widgets/custom_auth_image.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_constats.dart';

import '../../../../../../core/utils/assets_data.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/gradient_container.dart';
import 'reset_password_form.dart';

class RestPasswordPageBody extends StatefulWidget {
  const RestPasswordPageBody({super.key});

  @override
  State<RestPasswordPageBody> createState() => _RestPasswordPageBodyState();
}

class _RestPasswordPageBodyState extends State<RestPasswordPageBody> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final TextEditingController _phoneController;
  AuthType selectedAuthType = AuthType.phone;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _phoneController = TextEditingController();
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
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return GradientContainer(
      child: Column(
        children: [
          SafeArea(
              child: CustomAppBar(
                  title: "rest_password".tr(context), backBtn: true)),
          SizedBox(
            height: size.height * 0.02,
          ),
          const Expanded(
              flex: 1, child: CustomAuthImage(image: AssetsData.resetPassword)),
          CustomAuthContainer(
            child: ListView(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.05, horizontal: kHorizontalPadding),
              children: [
                Text(
                  "enter_phone_num_to_reset_pass".tr(context),
                  textAlign: TextAlign.center,
                  style: Styles.textStyle20.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                RestPasswordForm(
                    formKey: _formKey,
                    onAuthTypeChanged: _handleAuthTypeChanged,
                    phoneController: _phoneController,
                    selectedAuthType: selectedAuthType,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    confirmPasswordController: _confirmPasswordController),
                CustomButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                  child: Text(
                    "continue".tr(context),
                    style: Styles.textStyle15.copyWith(color: Colors.white),
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
