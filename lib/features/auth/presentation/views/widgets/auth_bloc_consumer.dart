import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuhoud/core/utils/app_localizations.dart';

import '../../../../../core/utils/styles.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../core/widgets/custom_snak_bar.dart';
import '../../view-model/auth_cubit.dart';

class AuthBlocConsumer extends StatelessWidget {
  final VoidCallback onPressed;
  final VoidCallback onSuccess;
  final String buttonText;
  final AuthCubit cubit;

  const AuthBlocConsumer({
    super.key,
    required this.onPressed,
    required this.onSuccess,
    required this.buttonText,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          CustomSnackBar.showSnackBar(
            context: context,
            title: 'error'.tr(context),
            message: state.message,
            contentType: ContentType.failure,
          );
        }
        if (state is AuthSuccess) {
          onSuccess();
        }
      },
      builder: (context, state) {
        return CustomButton(
          onPressed: state is AuthLoading ? () {} : onPressed,
          child: state is AuthLoading
              ? const CustomCircularProgressIndicator()
              : Text(
                  buttonText,
                  style: Styles.textStyle15.copyWith(color: Colors.white),
                ),
        );
      },
    );
  }
}
