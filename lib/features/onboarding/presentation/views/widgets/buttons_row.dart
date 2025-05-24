import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../core/widgets/custom_button.dart';

class ButtonsRow extends StatelessWidget {
  const ButtonsRow(
      {super.key,
      required this.primaryOnpressed,
      required this.secondaryOnpressed,
      required this.primaryText,
      required this.secondaryText});
  final Function() primaryOnpressed;
  final Function() secondaryOnpressed;
  final String primaryText;
  final String secondaryText;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            onPressed: secondaryOnpressed,
            primaryGradinetColor: AppColors.skipButtonStartColor,
            secodanryGradinetColor: AppColors.skipButtonEndColor,
            child: Text(
              secondaryText,
              style: Styles.textStyle16.copyWith(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: CustomButton(
            onPressed: primaryOnpressed,
            child: Text(
              primaryText,
              style: Styles.textStyle16.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
