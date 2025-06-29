import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/styles.dart';

import '../../../../../core/widgets/custom_button.dart';

class JobMatchCard extends StatelessWidget {
  final String jobTitle;
  final String company;
  final String matchReason;
  final int matchScore;
  final VoidCallback onReadMore;

  const JobMatchCard({
    super.key,
    required this.jobTitle,
    required this.company,
    required this.matchReason,
    required this.matchScore,
    required this.onReadMore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor),
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(jobTitle, style: _headingTextStyle),
                    const SizedBox(height: 4),
                    Text(company, style: _subHeadingTextStyle),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '$matchScore%',
                        style: Styles.textStyle16.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'نسبة التطابق',
                    style: Styles.textStyle13.copyWith(
                      color: AppColors.subHeadingTextColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(
                Icons.emoji_events_outlined,
                size: 20,
                color: AppColors.subHeadingTextColor,
              ),
              const SizedBox(width: 8),
              Text(
                'سبب التطابق:',
                style: Styles.textStyle16.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.headingTextColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            matchReason,
            style: _subHeadingTextStyle,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          CustomButton(
            onPressed: onReadMore,
            primaryGradinetColor: AppColors.skipButtonStartColor,
            secodanryGradinetColor: AppColors.skipButtonEndColor,
            height: 40,
            verticalHieght: 0,
            horizontalWidth: 0,
            child: Text(
              'قراء المزيد',
              style: Styles.textStyle16.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle get _headingTextStyle => Styles.textStyle18.copyWith(
        color: AppColors.headingTextColor,
        fontWeight: FontWeight.bold,
      );

  TextStyle get _subHeadingTextStyle => Styles.textStyle16.copyWith(
        color: AppColors.subHeadingTextColor,
      );
}
