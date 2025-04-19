import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/services_locater.dart';
import '../../view-model/auth_cubit.dart';
import 'widgets/login_page_body.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getit.get<AuthCubit>(),
      child: const Scaffold(
        body: LoginPageBody(),
      ),
    );
  }
}
