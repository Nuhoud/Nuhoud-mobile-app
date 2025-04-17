import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../../../../../../core/utils/app_constats.dart';
import '../../../../../../core/utils/styles.dart';

class CustomOptField extends StatelessWidget {
  const CustomOptField({
    super.key,
    required this.size,
    this.onSubmit,
  });

  final Size size;
  final void Function(String)? onSubmit;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: OtpTextField(
              onSubmit: onSubmit,
              filled: true,
              fillColor: Colors.white.withOpacity(0.5),
              borderColor: Colors.white70,
              focusedBorderColor: Colors.white70,
              cursorColor: Colors.white70,
              fieldWidth: size.width * 0.15,
              showFieldAsBox: true,
              numberOfFields: 5,
              borderRadius: BorderRadius.circular(kBorderRadius),
              textStyle: Styles.textStyle18.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
