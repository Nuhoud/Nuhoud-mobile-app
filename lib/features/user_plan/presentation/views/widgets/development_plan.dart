import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/styles.dart';
import '../../../data/models/user_plan_model.dart';
import 'week_tasks_view.dart';

class DevelopmentPlan extends StatelessWidget {
  final List<Month> months;

  const DevelopmentPlan({super.key, required this.months});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: months.length,
      itemBuilder: (context, monthIndex) {
        final month = months[monthIndex];
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                month.month,
                style: Styles.textStyle18.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.headingTextColor,
                ),
              ),
              const SizedBox(height: 16),
              ...month.tasks.map((week) => WeekTasksView(week: week)),
            ],
          ),
        );
      },
    );
  }
}
