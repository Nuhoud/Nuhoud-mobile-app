import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/styles.dart';
import 'custom_dash_border.dart';

class UploadContainer extends StatelessWidget {
  const UploadContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DashedBorder(
      dashWidth: size.width * 0.03,
      dashSpace: size.width * 0.015,
      strokeWidth: 2.0,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: size.height * 0.25,
          constraints: const BoxConstraints(
            minHeight: 150,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffe5f6ff),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.file_upload_outlined,
                size: size.width * 0.17,
                color: AppColors.primaryColor,
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                'أرفع السيرة الذاتية هنا',
                style: Styles.textStyle20.copyWith(
                  color: AppColors.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'تصفح الملفات',
                style: Styles.textStyle18.copyWith(
                  decoration: TextDecoration.underline,
                  decorationThickness: 1,
                  decorationColor: AppColors.primaryColor,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
