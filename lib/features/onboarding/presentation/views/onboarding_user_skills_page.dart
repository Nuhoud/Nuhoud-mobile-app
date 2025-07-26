import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuhoud/core/shared/cubits/skills_cubit/skills_cubit.dart';
import 'package:nuhoud/core/utils/app_colors.dart';
import 'package:nuhoud/core/utils/services_locater.dart';
import 'package:nuhoud/core/widgets/custom_circular_progress_indicator.dart';
import 'package:nuhoud/core/widgets/custom_error_widget.dart';

import 'widgets/onboarding_user_skilles/onboarding_user_skills_page_body.dart';

class OnboardingUserSkillsPage extends StatelessWidget {
  const OnboardingUserSkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getit<SkillsCubit>()..getSkills(),
      child: Scaffold(
        body: BlocBuilder<SkillsCubit, SkillsState>(
          builder: (context, state) {
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
                  });
            }
            if (state is SkillsSuccess) {
              return OnboardingUserSkillsPageBody(
                skills: state.skills,
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
