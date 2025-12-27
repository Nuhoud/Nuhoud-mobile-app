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

  String _getDeadlineText(int days) {
    if (days == 0) return "ينتهي اليوم";
    if (days == 1) return "يوم واحد";
    return "$days أيام";
  }

  // Helper function to get deadline background color
  Color _getDeadlineBackgroundColor(int days) {
    if (days == 0) return Colors.red[100]!;
    if (days <= 2) return Colors.orange[100]!;
    return const Color.fromARGB(255, 162, 250, 167).withValues(alpha: 0.8);
  }

  // Helper function to get deadline text color
  Color _getDeadlineTextColor(int days) {
    if (days == 0) return Colors.red[800]!;
    if (days <= 2) return Colors.orange[800]!;
    return AppColors.subHeadingTextColor;
  }

  @override
  Widget build(BuildContext context) {
    // this navigation is true?
    return GestureDetector(
      onTap: () => GoRouter.of(context).go(Routers.kJobDetailsPage, extra: job.id),
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(job.title, style: headingTextStyle),
                      Text(job.companyName, style: subHeadingTextStyle),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${job.jobType}/ ${job.workPlaceType}", style: subHeadingTextStyle),
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
                Text("${job.salaryRange.min}-${job.salaryRange.max} ${getCurrencyArabic(job.salaryRange.currency)}",
                    style: subHeadingTextStyle),
              ],
            ),
            if (job.daysRemaining >= 0) ...[
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getDeadlineBackgroundColor(job.daysRemaining),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: _getDeadlineTextColor(job.daysRemaining),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _getDeadlineText(job.daysRemaining),
                        style: subHeadingTextStyle.copyWith(
                          color: _getDeadlineTextColor(job.daysRemaining),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  TextStyle get headingTextStyle =>
      Styles.textStyle18.copyWith(color: AppColors.headingTextColor, fontWeight: FontWeight.bold);
  TextStyle get subHeadingTextStyle => Styles.textStyle16.copyWith(color: AppColors.subHeadingTextColor);
}
