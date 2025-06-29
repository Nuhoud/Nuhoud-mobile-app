import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/app_colors.dart';
import 'package:nuhoud/core/utils/styles.dart';

import '../../../data/models/user_plan_model.dart';

class WeekTasksView extends StatelessWidget {
  final WeekTasks week;

  const WeekTasksView({super.key, required this.week});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'الأسبوع ${week.week}',
            style: Styles.textStyle16.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.headingTextColor,
            ),
          ),
          const SizedBox(height: 8),
          ...week.tasks.map((task) => Padding(
                padding: const EdgeInsets.only(left: 8, top: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ',
                        style: TextStyle(color: AppColors.subHeadingTextColor)),
                    Expanded(
                      child: Text(
                        task,
                        style: Styles.textStyle16
                            .copyWith(color: AppColors.subHeadingTextColor),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
