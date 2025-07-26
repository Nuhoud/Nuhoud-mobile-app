import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/app_colors.dart';
import 'package:nuhoud/core/utils/styles.dart';
import 'package:nuhoud/features/user_plan/data/models/user_plan_model.dart';
import 'widgets/development_plan.dart';
import 'widgets/job_courser.dart';

class UserPlanPageBody extends StatefulWidget {
  final UserPlanModel userPlanModel;
  const UserPlanPageBody({super.key, required this.userPlanModel});

  @override
  State<UserPlanPageBody> createState() => _UserPlanPageBodyState();
}

class _UserPlanPageBodyState extends State<UserPlanPageBody> {
  int _currentStep = 0;

  List<Step> _buildSteps() {
    return [
      Step(
        title: Text('الخطوة الأولى: الوظائف المقترحة',
            style: Styles.textStyle18.copyWith(
              color: _currentStep == 0 ? AppColors.primaryColor : AppColors.subHeadingTextColor,
              fontWeight: FontWeight.bold,
            )),
        content: JobCarousel(jobs: widget.userPlanModel.step1.jobs),
        isActive: _currentStep == 0,
        state: _currentStep > 0 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Text('الخطوة الثانية: خطة التطوير',
            style: Styles.textStyle18.copyWith(
              color: _currentStep == 1 ? AppColors.primaryColor : AppColors.subHeadingTextColor,
              fontWeight: FontWeight.bold,
            )),
        content: DevelopmentPlan(months: widget.userPlanModel.step2.months),
        isActive: _currentStep == 1,
        state: _currentStep > 1 ? StepState.complete : StepState.indexed,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: AppColors.primaryColor,
            ),
        unselectedWidgetColor: AppColors.borderColor,
      ),
      child: Stepper(
        currentStep: _currentStep,
        onStepTapped: (step) => setState(() => _currentStep = step),
        steps: _buildSteps(),
        controlsBuilder: (context, details) => const SizedBox.shrink(),
      ),
    );
  }
}
