import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nuhoud/core/utils/app_colors.dart';
import 'package:nuhoud/core/utils/assets_data.dart';
import 'package:nuhoud/core/utils/styles.dart';
import 'package:nuhoud/features/home/data/models/job_model.dart';
import 'package:nuhoud/core/utils/routs.dart';

class JobApplicationItem extends StatelessWidget {
  const JobApplicationItem({
    super.key,
    required this.job,
  });
  final JobModel job;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).push(Routers.kJobDetailsPage, extra: job),
      child: Container(
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
              children: [
                Image.asset(
                  AssetsData.logo,
                  width: 50,
                  height: 50,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(job.title, style: headingTextStyle),
                    Text(job.companyName, style: subHeadingTextStyle),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(job.jobType, style: subHeadingTextStyle),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(job.jobLocation, style: subHeadingTextStyle)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    job.experienceLevel,
                    style: subHeadingTextStyle,
                  ),
                ),
                Text(job.salaryRange.min.toString(), style: subHeadingTextStyle),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextStyle get headingTextStyle =>
      Styles.textStyle18.copyWith(color: AppColors.headingTextColor, fontWeight: FontWeight.bold);
  TextStyle get subHeadingTextStyle => Styles.textStyle16.copyWith(color: AppColors.subHeadingTextColor);
}
