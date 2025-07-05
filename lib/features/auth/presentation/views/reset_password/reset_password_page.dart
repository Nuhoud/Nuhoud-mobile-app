import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuhoud/core/utils/services_locater.dart';
import 'package:nuhoud/features/auth/presentation/view-model/auth_cubit.dart';

import 'widgets/reset_password_page_body.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getit.get<AuthCubit>(),
      child: const Scaffold(
        body: RestPasswordPageBody(),
      ),
    );
  }
}
