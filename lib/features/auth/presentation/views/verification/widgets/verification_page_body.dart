import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/app_localizations.dart';
import 'package:nuhoud/features/auth/presentation/views/widgets/app_logo_image.dart';

import '../../../../../../core/utils/app_constats.dart';

import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/gradient_container.dart';
import 'custom_opt_field.dart';
import 'resend_code.dart';
import 'verification_msg.dart';

class VerificationPagebody extends StatefulWidget {
  const VerificationPagebody(
      {super.key, required this.email, required this.isFromRigster});
  final String email;
  final bool isFromRigster;
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
      // BlocProvider.of<ResetPasswordCubit>(context)
      //     .resendCode(phone: widget.phoneNumber);
      _startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);

    return SafeArea(
      child: GradientContainer(
        child: ListView(
          children: [
            const AppLogoImage(),
            Center(
              child: Text(
                textAlign: TextAlign.center,
                "enter_the_code_to_continue".tr(context),
                style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(height: kSizedBoxHeight),
            VerificationMsg(email: widget.email),
            SizedBox(height: size.height * 0.05),
            CustomOptField(
                size: size,
                onSubmit: (value) {
                  setState(() => _otpValue = value);
                }),
            const SizedBox(height: kSizedBoxHeight),
            ResendCode(
                onPressed: _canResend ? _resendCode : null,
                canResend: _canResend,
                remainingTime: _remainingTime),
            const SizedBox(height: kSizedBoxHeight),
            if (widget.isFromRigster)
              CustomButton(
                child: Text(
                  "verfi_num".tr(context),
                  style: theme.textTheme.titleMedium!
                      .copyWith(color: Colors.white),
                ),
                onPressed: () {
                  if (_otpValue.isNotEmpty && _otpValue.length == 6) {}
                },
              ),
            // if (widget.fromRigster)
            //   RegisterBlocConsumer(
            //       theme: theme,
            //       otpValue: _otpValue,
            //       phoneNumber: widget.phoneNumber),
            // if (!widget.fromRigster)
            // VerfiResetPasswrodBlocConsumer(
            //     theme: theme,
            //     otpValue: _otpValue,
            //     phoneNumber: widget.phoneNumber)
          ],
        ),
      ),
    );
  }
}
