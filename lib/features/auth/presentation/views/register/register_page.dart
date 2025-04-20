import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;
import '../../../../../core/utils/services_locater.dart';
import '../../view-model/auth_cubit.dart';
import 'widgets/register_page_body.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getit.get<AuthCubit>(),
      child: const Scaffold(
        body: RegisterPageBody(),
      ),
    );
  }
}
