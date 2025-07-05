import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nuhoud/core/utils/app_colors.dart';
import 'package:nuhoud/core/utils/app_constats.dart';
import 'package:nuhoud/core/utils/app_localizations.dart';
import 'package:nuhoud/core/utils/assets_data.dart';
import 'package:nuhoud/core/utils/enums.dart';
import 'package:nuhoud/core/utils/routs.dart';
import 'package:nuhoud/core/utils/services_locater.dart';
import 'package:nuhoud/core/utils/styles.dart';
import 'package:nuhoud/core/widgets/custom_app_bar.dart';
import 'package:nuhoud/core/widgets/gradient_container.dart';
import 'package:nuhoud/features/auth/presentation/view-model/auth_cubit.dart';
import 'package:nuhoud/features/auth/presentation/views/verification/verification_page.dart';
import 'package:nuhoud/features/auth/presentation/views/widgets/auth_bloc_consumer.dart';
import 'package:nuhoud/features/auth/presentation/views/widgets/custom_auth_container.dart';
import 'package:nuhoud/features/auth/presentation/views/widgets/custom_auth_image.dart';
import 'package:nuhoud/features/auth/presentation/views/widgets/custom_segmented_button.dart';
import 'package:nuhoud/features/auth/presentation/views/widgets/email_phone_text_field.dart';

class RequestResetPasswordPageBody extends StatefulWidget {
  const RequestResetPasswordPageBody({super.key});

  @override
  State<RequestResetPasswordPageBody> createState() => _RequestResetPasswordPageBodyState();
}

class _RequestResetPasswordPageBodyState extends State<RequestResetPasswordPageBody> {
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  AuthType selectedAuthType = AuthType.phone;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
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
    _phoneController.dispose();
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
                  "الرجاء ادخال رقمك او بريدك الالكتروني لاعادة تعين كلمة المرور",
                  textAlign: TextAlign.center,
                  style: Styles.textStyle20.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                CustomSegmentedButton(
                  onAuthTypeChanged: _handleAuthTypeChanged,
                  selectedAuthType: selectedAuthType,
                ),
                Form(
                    key: _formKey,
                    child: EmailPhoneTextField(
                        selectedAuthType: selectedAuthType,
                        emailController: _emailController,
                        phoneController: _phoneController)),
                AuthBlocConsumer(
                  cubit: getit.get<AuthCubit>(),
                  buttonText: "continue".tr(context),
                  onPressed: () {
                    {
                      final identifier =
                          selectedAuthType == AuthType.email ? _emailController.text : _phoneController.text;
                      context
                          .read<AuthCubit>()
                          .requestResetPassword(identifier: identifier, authType: selectedAuthType);
                    }
                  },
                  onSuccess: () {
                    final identifier =
                        selectedAuthType == AuthType.email ? _emailController.text : _phoneController.text;
                    GoRouter.of(context).pushReplacement(Routers.kVerificationPageRoute,
                        extra: VerificationArgs(
                            selectedAuthType: selectedAuthType, emailOrPhone: identifier, isFromRegister: false));
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
