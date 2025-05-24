import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view-model/onboarding_cuibt/onboarding_cubit.dart';
import 'widgets/onboarding_user_education_info/onboarding_user_education_page_body.dart';

class OnboardingUserEducationInfoPage extends StatelessWidget {
  const OnboardingUserEducationInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: const Scaffold(
        body: OnboardingUserEducationPageBody(),
      ),
    );
  }
}
