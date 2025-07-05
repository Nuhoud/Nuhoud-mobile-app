import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuhoud/core/utils/services_locater.dart';
import 'package:nuhoud/features/auth/presentation/view-model/auth_cubit.dart';
import 'package:nuhoud/features/auth/presentation/views/reset_password/widgets/requset_reset_password_page_body.dart';

class RequestResetPasswordPage extends StatelessWidget {
  const RequestResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getit.get<AuthCubit>(),
        child: const RequestResetPasswordPageBody(),
      ),
    );
  }
}
