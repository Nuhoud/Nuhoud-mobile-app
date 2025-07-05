import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nuhoud/core/utils/app_localizations.dart';
import 'package:nuhoud/core/utils/routs.dart';
import 'package:nuhoud/core/utils/services_locater.dart';
import 'package:nuhoud/core/utils/styles.dart';
import 'package:nuhoud/core/widgets/custom_app_bar.dart';
import 'package:nuhoud/features/auth/presentation/view-model/auth_cubit.dart';
import 'package:nuhoud/features/auth/presentation/views/widgets/auth_bloc_consumer.dart';
import 'package:nuhoud/features/auth/presentation/views/widgets/custom_auth_container.dart';
import 'package:nuhoud/features/auth/presentation/views/widgets/custom_auth_image.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_constats.dart';

import '../../../../../../core/utils/assets_data.dart';
import '../../../../../../core/widgets/custom_snak_bar.dart';
import '../../../../../../core/widgets/gradient_container.dart';
import 'reset_password_form.dart';

class RestPasswordPageBody extends StatefulWidget {
  const RestPasswordPageBody({super.key});

  @override
  State<RestPasswordPageBody> createState() => _RestPasswordPageBodyState();
}

class _RestPasswordPageBodyState extends State<RestPasswordPageBody> {
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return GradientContainer(
      child: Column(
        children: [
          SafeArea(child: CustomAppBar(title: "rest_password".tr(context), backBtn: true)),
          SizedBox(
            height: size.height * 0.02,
          ),
          const Expanded(flex: 1, child: CustomAuthImage(image: AssetsData.resetPassword)),
          CustomAuthContainer(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.05, horizontal: kHorizontalPadding),
              children: [
                Text(
                  "الرجاء ادخال كلمة المرور الجديدة",
                  textAlign: TextAlign.center,
                  style: Styles.textStyle20.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                RestPasswordForm(
                    formKey: _formKey,
                    passwordController: _passwordController,
                    confirmPasswordController: _confirmPasswordController),
                AuthBlocConsumer(
                  cubit: getit.get<AuthCubit>(),
                  buttonText: "confirm".tr(context),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthCubit>().resetPassword(
                            password: _passwordController.text,
                          );
                    }
                  },
                  onSuccess: () {
                    CustomSnackBar.showSnackBar(
                        context: context,
                        title: "success".tr(context),
                        message: "تم اعادة تعين كلمة المرور بنجاح",
                        contentType: ContentType.success);
                    GoRouter.of(context).push(Routers.kLoginPageRoute);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
