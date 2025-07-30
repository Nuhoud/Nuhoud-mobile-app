import 'package:flutter/material.dart';
import 'package:nuhoud/features/home/data/models/job_model.dart';
import 'package:nuhoud/features/home/presentation/views/widgets/job_appliction_item.dart';
import 'package:nuhoud/features/profile/presentation/views/proflie_page.dart';
import 'package:nuhoud/features/user_plan/data/models/user_plan_model.dart';
import 'package:nuhoud/features/user_plan/presentation/views/widgets/development_plan.dart';
import 'package:nuhoud/features/user_plan/presentation/views/widgets/job_courser.dart';
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

  static Widget profileSkeletonizer() {
    return Skeletonizer(
        enabled: true,
        justifyMultiLineText: true,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          itemCount: 7,
          itemBuilder: (context, index) {
            return ProfileItem(
              title: "random text",
              icon: Icons.person,
              onTap: () {},
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 16),
        ));
  }

  static Widget userPlanSkeletonizer() {
    final dummyUserPlan = UserPlanModel(
        step1: Step1(
            jobs: List.generate(
                3,
                (index) => Job(
                    id: 'dummy$index',
                    title: 'Job Title',
                    company: 'Company Name',
                    match: 'Job match description',
                    matchScore: 0,
                    employerId: ""))),
        step2: Step2(
          months: List.generate(
              2,
              (index) => Month(
                    month: 'Month ${index + 1}',
                    tasks: List.generate(
                        2,
                        (i) => WeekTasks(
                              week: i + 1,
                              tasks: List.generate(3, (j) => 'Task ${j + 1}'),
                            )),
                  )),
        ));

    return Skeletonizer(
      enabled: true,
      child: Theme(
        data: ThemeData(),
        child: Stepper(
          currentStep: 0,
          steps: [
            Step(
              title: Text('الخطوة الأولى: الوظائف المقترحة'),
              content: JobCarousel(jobs: dummyUserPlan.step1.jobs),
            ),
            Step(
              title: Text('الخطوة الثانية: خطة التطوير'),
              content: DevelopmentPlan(months: dummyUserPlan.step2.months),
            ),
          ],
          controlsBuilder: (context, details) => const SizedBox.shrink(),
        ),
      ),
    );
  }
}
