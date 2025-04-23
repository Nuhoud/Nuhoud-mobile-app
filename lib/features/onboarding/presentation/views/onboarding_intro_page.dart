import 'package:flutter/material.dart';

import 'widgets/onboarding_intro/onboarding_intro_page_body.dart';

class OnboardingIntroPage extends StatelessWidget {
  const OnboardingIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OnboardingIntroPageBody(),
    );
  }
}
