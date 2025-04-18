import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/enums.dart';
import 'package:nuhoud/features/auth/presentation/views/verification/widgets/verification_page_body.dart';

class VerificationArgs {
  final String emailOrPhone;
  final bool isFromRegister;
  final AuthType selectedAuthType;
  VerificationArgs({
    required this.selectedAuthType,
    required this.emailOrPhone,
    required this.isFromRegister,
  });
}

class VerificationPage extends StatelessWidget {
  final String email;
  final bool isFromRegiter;
  final AuthType selectedAuthType;
  const VerificationPage(
      {super.key,
      required this.email,
      required this.isFromRegiter,
      required this.selectedAuthType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VerificationPagebody(
        email: email,
        isFromRigster: isFromRegiter,
        selectedAuthType: selectedAuthType,
      ),
    );
  }
}
