import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nuhoud/core/utils/app_localizations.dart';

import '../../../../../../core/utils/routs.dart';
import '../../../../../../core/utils/styles.dart';

class SignUpForgetPassWidget extends StatelessWidget {
  const SignUpForgetPassWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextButtonWidget(
          text: "sing_up".tr(context),
          onPressed: () {
            GoRouter.of(context).push(Routers.kRegisterPageRoute);
          },
        ),
        CustomTextButtonWidget(
          text: "forgot_password".tr(context),
          onPressed: () {},
        ),
      ],
    );
  }
}

class CustomTextButtonWidget extends StatelessWidget {
  const CustomTextButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
  });
  final String text;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: Styles.textStyle15.copyWith(
          decoration: TextDecoration.underline,
          decorationThickness: 0.6,
          decorationColor: Colors.white,
          color: Colors.white,
        ),
      ),
    );
  }
}
