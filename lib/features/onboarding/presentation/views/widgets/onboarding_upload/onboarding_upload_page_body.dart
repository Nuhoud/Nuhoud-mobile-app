import 'package:flutter/material.dart';

import '../../../../../../core/utils/assets_data.dart';
import '../onboardin_image.dart';
import 'skip_coninue_buttons.dart';
import 'upload_container.dart';

class OnboardingUploadPageBody extends StatelessWidget {
  const OnboardingUploadPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        child: ListView(
          children: const [
            OnBordingImage(image: AssetsData.upload),
            UploadContainer(),
            SkipConinueButtons(),
          ],
        ),
      ),
    );
  }
}
