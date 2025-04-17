import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/app_localizations.dart';

class VerificationMsg extends StatelessWidget {
  const VerificationMsg({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text.rich(
        TextSpan(
          text: "pleas_enter_the_number".tr(context),
          style: theme.textTheme.bodyLarge?.copyWith(
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: email,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
