import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nuhoud/core/utils/app_constats.dart';
import 'package:nuhoud/core/utils/app_localizations.dart';
import 'package:nuhoud/core/utils/assets_data.dart';
import 'package:nuhoud/core/utils/enums.dart';
import 'package:nuhoud/core/utils/routs.dart';
import 'package:nuhoud/core/widgets/custom_snak_bar.dart';
import 'package:nuhoud/features/auth/presentation/views/widgets/custom_auth_image.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/services_locater.dart';
import '../../../../../../core/widgets/gradient_container.dart';
import '../../../view-model/auth_cubit.dart';
import '../../widgets/auth_bloc_consumer.dart';
import '../../widgets/custom_auth_container.dart';
import 'custom_opt_field.dart';
import 'resend_code.dart';
import 'verification_msg.dart';

class VerificationPagebody extends StatefulWidget {
  const VerificationPagebody(
      {super.key, required this.identifier, required this.isFromRigster, required this.selectedAuthType});
  final String identifier;
  final bool isFromRigster;
  final AuthType selectedAuthType;
  @override
  State<VerificationPagebody> createState() => _VerificationPagebodyState();
}

class _VerificationPagebodyState extends State<VerificationPagebody> {
  late Timer _timer;
  int _remainingTime = 60;
  bool _canResend = false;
  String _otpValue = '';

  @override
  void initState() {
    context.read<AuthCubit>().resetState();
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _canResend = false;
    _remainingTime = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() => _remainingTime--);
      } else {
        _timer.cancel();
        setState(() => _canResend = true);
      }
    });
  }

  void _resendCode() {
    if (_canResend) {
      context.read<AuthCubit>().resendOtp(identifier: widget.identifier, authType: widget.selectedAuthType);
      _startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is OptSendSuccess) {
          CustomSnackBar.showSnackBar(
              context: context,
              title: "نجاح",
              message: "success_code_send_agen".tr(context),
              contentType: ContentType.success);
        }
        if (state is OptError) {
          CustomSnackBar.showSnackBar(
              context: context, title: "error".tr(context), message: state.message, contentType: ContentType.failure);
        }
      },
      child: SafeArea(
        child: GradientContainer(
          child: Column(
            children: [
              const Expanded(flex: 1, child: CustomAuthImage(image: AssetsData.verify)),
              Expanded(
                flex: 2,
                child: CustomAuthContainer(
                  child: ListView(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.05, horizontal: kHorizontalPadding),
                    children: [
                      Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          widget.selectedAuthType == AuthType.email
                              ? "enter_the_code_to_continue_email".tr(context)
                              : "enter_the_code_to_continue_phone".tr(context),
                          style: theme.textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                        ),
                      ),
                      SizedBox(height: size.height * 0.05),
                      VerificationMsg(
                        emailOrPhone: widget.identifier,
                        selectedAuthType: widget.selectedAuthType,
                      ),
                      CustomOptField(onSubmit: (value) {
                        setState(() => _otpValue = value);
                      }),
                      ResendCode(
                          onPressed: _canResend ? _resendCode : null,
                          canResend: _canResend,
                          remainingTime: _remainingTime),
                      AuthBlocConsumer(
                        buttonText: "verfi_num".tr(context),
                        cubit: getit.get<AuthCubit>(),
                        onPressed: () {
                          if (_otpValue.isNotEmpty && _otpValue.length == 5) {
                            if (widget.isFromRigster) {
                              context.read<AuthCubit>().verifyOtp(
                                  identifier: widget.identifier, otp: _otpValue, authType: widget.selectedAuthType);
                            } else {
                              context.read<AuthCubit>().verifyResetPasswordOtp(
                                  identifier: widget.identifier, otp: _otpValue, authType: widget.selectedAuthType);
                            }
                          }
                        },
                        onSuccess: () {
                          if (widget.isFromRigster) {
                            GoRouter.of(context).pushReplacement(Routers.kOndboardingIntroPage);
                          } else {
                            GoRouter.of(context).pushReplacement(Routers.kRestPasswordPage);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
