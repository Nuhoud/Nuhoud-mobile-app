import 'package:flutter/material.dart';
import 'package:nuhoud/features/auth/presentation/views/verification/widgets/verification_page_body.dart';

class VerificationArgs {
  final String email;
  final bool isFromRegister;

  VerificationArgs({
    required this.email,
    required this.isFromRegister,
  });
}

class VerificationPage extends StatelessWidget {
  final String email;
  final bool isFromRegiter;
  const VerificationPage(
      {super.key, required this.email, required this.isFromRegiter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VerificationPagebody(email: email, isFromRigster: isFromRegiter),
    );
  }
}
