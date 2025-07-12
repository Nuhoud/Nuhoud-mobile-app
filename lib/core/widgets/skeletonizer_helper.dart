import 'package:flutter/material.dart';
import 'package:nuhoud/features/home/data/models/job_model.dart';
import 'package:nuhoud/features/home/presentation/views/widgets/job_appliction_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonizerHelper {
  static Widget homeSkeletonizer() {
    return Skeletonizer(
      enabled: true,
      justifyMultiLineText: true,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        itemCount: 7,
        itemBuilder: (context, index) {
          return JobApplicationItem(
              job: JobModel(
            title: "random text",
            experienceLevel: "random text",
            workPlaceType: "random text",
            jobType: "random text",
            jobLocation: "random text",
            description: "random text",
            requirements: [],
            skillsRequired: [],
            salaryRange: SalaryRange(min: 10, max: 1000, currency: "SYP"),
            companyName: "",
            deadline: DateTime.now(),
            employerId: "",
            id: "",
            applicationsCount: 0,
            isActive: true,
            isExpired: false,
            status: "",
            postedAt: DateTime.now(),
            daysRemaining: 0,
          ));
        },
        separatorBuilder: (context, index) => const SizedBox(height: 16),
      ),
    );
  }
}
