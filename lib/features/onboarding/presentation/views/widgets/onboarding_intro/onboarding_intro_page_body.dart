import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nuhoud/core/utils/app_localizations.dart';
import 'package:nuhoud/core/widgets/custom_button.dart';
import 'package:nuhoud/features/onboarding/presentation/views/widgets/onboardin_image.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/assets_data.dart';
import '../../../../../../core/utils/routs.dart';
import '../../../../../../core/utils/styles.dart';
import 'intro_info.dart';

class OnboardingIntroPageBody extends StatelessWidget {
  const OnboardingIntroPageBody({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        child: ListView(
          children: [
            const OnBordingImage(image: AssetsData.search),
            const IntroInfo(),
            CustomButton(
              onPressed: () {
                GoRouter.of(context).push(Routers.kOndboardingUserBasicPage);
              },
              horizontalWidth: MediaQuery.of(context).size.width * 0.15,
              child: Text(
                'continue'.tr(context),
                style: Styles.textStyle20.copyWith(
                  color: AppColors.fillTextFiledColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
