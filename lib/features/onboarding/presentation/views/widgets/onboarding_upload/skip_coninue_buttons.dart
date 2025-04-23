import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/app_localizations.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/custom_button.dart';

class SkipConinueButtons extends StatelessWidget {
  const SkipConinueButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        top: size.height * 0.04,
        bottom: size.height * 0.03,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomButton(
              onPressed: () {},
              child: Text(
                'continue'.tr(context),
                style: Styles.textStyle16.copyWith(
                  color: AppColors.fillTextFiledColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: size.width * 0.04),
          Expanded(
            child: CustomButton(
              onPressed: () {},
              primaryGradinetColor: AppColors.skipButtonStartColor,
              secodanryGradinetColor: AppColors.skipButtonEndColor,
              child: Text(
                'skip'.tr(context),
                style: Styles.textStyle16.copyWith(
                  color: AppColors.fillTextFiledColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
