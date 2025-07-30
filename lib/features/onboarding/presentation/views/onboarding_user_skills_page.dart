import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuhoud/core/shared/cubits/skills_cubit/skills_cubit.dart';
import 'package:nuhoud/core/utils/app_colors.dart';
import 'package:nuhoud/core/widgets/custom_circular_progress_indicator.dart';
import 'package:nuhoud/core/widgets/custom_error_widget.dart';
import 'package:nuhoud/core/widgets/waiting_message_with_dots.dart';

import 'widgets/onboarding_user_skilles/onboarding_user_skills_page_body.dart';

class OnboardingUserSkillsPage extends StatefulWidget {
  const OnboardingUserSkillsPage({super.key});

  @override
  State<OnboardingUserSkillsPage> createState() => _OnboardingUserSkillsPageState();
}

class _OnboardingUserSkillsPageState extends State<OnboardingUserSkillsPage> {
  @override
  void initState() {
    super.initState();
    context.read<SkillsCubit>().getSkills();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SkillsCubit, SkillsState>(
        builder: (context, state) {
          if (state is GetSkillsFromAI) {
            return const WaitingMessageWithDots(
              message: "جاري إنشاء مهاراتك الشخصية بناءً على معلوماتك",
            );
          }
          if (state is SkillsLoading) {
            return const CustomCircularProgressIndicator(
              color: AppColors.primaryColor,
            );
          }
          if (state is SkillsError) {
            return CustomErrorWidget(
              errorMessage: state.message,
              onRetry: () {
                context.read<SkillsCubit>().getSkills();
              },
            );
          }
          if (state is SkillsSuccess) {
            return OnboardingUserSkillsPageBody(
              skills: state.skills,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
