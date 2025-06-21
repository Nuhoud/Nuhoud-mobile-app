import 'package:flutter/material.dart';
import 'package:nuhoud/features/home/presentation/views/widgets/job_appliction_item.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../data/models/job_model.dart';

class JobApplication extends StatelessWidget {
  final List<JobModel> jobs;
  const JobApplication({super.key, required this.jobs});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return CustomScrollView(
            slivers: [
              // Title Section
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Text(
                        "الوظائف المقترحة",
                        style: TextStyle(
                          color: AppColors.headingTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize:
                              MediaQuery.sizeOf(context).shortestSide * 0.07,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // list Section
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList.separated(
                  itemBuilder: (context, index) => JobApplicationItem(
                    job: jobs[index],
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 16,
                  ),
                  itemCount: jobs.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
