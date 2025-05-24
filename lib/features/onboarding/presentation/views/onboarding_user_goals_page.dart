import 'package:flutter/material.dart';

import 'widgets/onboarding_user_goals/onboarding_user_goals_page_body.dart';

class OnboardingUserGoalsPage extends StatelessWidget {
  const OnboardingUserGoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OnboardingUserGoalsPageBody(),
    );
  }
}
