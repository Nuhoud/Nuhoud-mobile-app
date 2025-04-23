import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/styles.dart';

class IntroInfo extends StatelessWidget {
  const IntroInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'مرحبا أيهم، أنا سند',
          style: Styles.textStyle30.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: size.height * 0.01),
        Text(
          'لنبذأ بتكوين هويتك المهنية معا\n'
          'سوف نساعدك علــى تحليــل خبراتــك\n'
          'وتحديد مهاراتك بدقة',
          style: Styles.textStyle18.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.blackTextColor,
            height: 1.8,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: size.height * 0.05),
      ],
    );
  }
}
