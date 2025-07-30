import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuhoud/core/utils/enums.dart';
import 'package:nuhoud/core/utils/services_locater.dart';
import 'package:nuhoud/features/auth/presentation/view-model/auth_cubit.dart';
import 'package:nuhoud/features/auth/presentation/views/verification/widgets/verification_page_body.dart';

class VerificationArgs {
  final String emailOrPhone;
  final bool isFromRegister;
  final AuthType selectedAuthType;
  final String? userName;
  VerificationArgs({
    this.userName,
    required this.selectedAuthType,
    required this.emailOrPhone,
    required this.isFromRegister,
  });
}

class VerificationPage extends StatelessWidget {
  final String email;
  final bool isFromRegiter;
  final AuthType selectedAuthType;
  final String? userName;
  const VerificationPage(
      {super.key, required this.email, required this.isFromRegiter, required this.selectedAuthType, this.userName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getit.get<AuthCubit>(),
      child: Scaffold(
        body: VerificationPagebody(
          identifier: email,
          isFromRigster: isFromRegiter,
          selectedAuthType: selectedAuthType,
          userName: userName,
        ),
      ),
    );
  }
}
