import 'package:flutter/material.dart';

import 'widgets/onboarding_user_basic_info/onboarding_user_basic_info_page_body.dart';

class OnboardingUserBasicInfoPage extends StatelessWidget {
  const OnboardingUserBasicInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OnboardingUserBasicInfoPageBody(),
    );
  }
}
