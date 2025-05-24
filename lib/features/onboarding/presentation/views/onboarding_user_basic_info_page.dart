import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuhoud/features/onboarding/presentation/view-model/onboarding_cuibt/onboarding_cubit.dart';

import 'widgets/onboarding_user_basic_info/onboarding_user_basic_info_page_body.dart';

class OnboardingUserBasicInfoPage extends StatelessWidget {
  const OnboardingUserBasicInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: const Scaffold(
        body: OnboardingUserBasicInfoPageBody(),
      ),
    );
  }
}
