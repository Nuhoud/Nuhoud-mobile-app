import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nuhoud/core/utils/routs.dart';
import 'package:nuhoud/core/widgets/custom_snak_bar.dart';
import 'package:nuhoud/features/onboarding/presentation/view-model/onboarding_cuibt/onboarding_cubit.dart';
import 'package:nuhoud/features/profile/data/models/profile_model.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/custom_drop_dpown_button.dart';
import '../onboarding_container.dart';

class OnboardingUserSkillsPageBody extends StatefulWidget {
  const OnboardingUserSkillsPageBody({super.key});

  @override
  State<OnboardingUserSkillsPageBody> createState() => _OnboardingUserSkillsPageBodyState();
}

class _OnboardingUserSkillsPageBodyState extends State<OnboardingUserSkillsPageBody> {
  final List<String> _selectedSoftSkills = [];
  final List<String> _selectedHardSkills = [];

  @override
  Widget build(BuildContext context) {
    final List<String> softSkills = [
      "التعاون",
      "التعلم",
      "التحدي",
      "التنظيم",
      "التفكير الإبداعي",
    ];
    final List<String> hardSkills = [
      "التعاون",
      "التعلم",
      "التحدي",
      "التنظيم",
      "التفكير الإبداعي",
    ];
    return OnBoardingContainer(
      withFixedHight: false,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text("مهاراتك", style: Styles.textStyle18.copyWith(color: AppColors.primaryColor)),
            const SizedBox(height: 10),
            CustomDropdownButton(
              text: "المهارات الشخصية",
              items: softSkills,
              value: _selectedSoftSkills.isNotEmpty ? _selectedSoftSkills.first : null,
              onChanged: (value) {
                if (value != null && !_selectedSoftSkills.contains(value)) {
                  setState(() {
                    _selectedSoftSkills.add(value);
                  });
                }
              },
              selectedItems: _selectedSoftSkills,
            ),
            Wrap(
              spacing: 8,
              children: _selectedSoftSkills
                  .map((skill) => Chip(
                        label: Text(skill),
                        backgroundColor: AppColors.secodaryColor.withValues(alpha: 0.2),
                        deleteIcon: const Icon(Icons.close),
                        onDeleted: () {
                          setState(() {
                            _selectedSoftSkills.remove(skill);
                          });
                        },
                      ))
                  .toList(),
            ),
            const SizedBox(height: 10),
            CustomDropdownButton(
              text: "المهارات التقنية",
              items: hardSkills,
              value: _selectedHardSkills.isNotEmpty ? _selectedHardSkills.first : null,
              onChanged: (value) {
                if (value != null && !_selectedHardSkills.contains(value)) {
                  setState(() {
                    _selectedHardSkills.add(value);
                  });
                }
              },
              selectedItems: _selectedHardSkills,
            ),
            Wrap(
              spacing: 8,
              children: _selectedHardSkills
                  .map((skill) => Chip(
                        label: Text(skill),
                        deleteIcon: const Icon(Icons.close),
                        backgroundColor: AppColors.secodaryColor.withValues(alpha: 0.2),
                        onDeleted: () {
                          setState(() {
                            _selectedHardSkills.remove(skill);
                          });
                        },
                      ))
                  .toList(),
            ),
            const SizedBox(height: 10),
            BlocConsumer<OnboardingCubit, OnboardingState>(
              listener: (context, state) {
                if (state is SaveUserSkillsSuccess) {
                  GoRouter.of(context).pushReplacement(Routers.kHomePageRoute);
                  CustomSnackBar.showSnackBar(
                    context: context,
                    title: "تم الحفظ",
                    message: "تم حفظ المهارات بنجاح",
                    contentType: ContentType.success,
                  );
                }
                if (state is SaveUserSkillsError) {
                  CustomSnackBar.showSnackBar(
                    context: context,
                    title: "خطأ",
                    message: state.message,
                    contentType: ContentType.failure,
                  );
                }
              },
              builder: (context, state) {
                return CustomButton(
                  isLoading: state is SaveUserSkillsLoading,
                  child: Text("التالي", style: Styles.textStyle16.copyWith(color: Colors.white)),
                  onPressed: () {
                    _saveUserSkills();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _saveUserSkills() {
    if (_selectedSoftSkills.isNotEmpty || _selectedHardSkills.isNotEmpty) {
      final skills = Skills(
        softSkills: _selectedSoftSkills.map((e) => TechnicalSkill(name: e)).toList(),
        technicalSkills: _selectedHardSkills.map((e) => TechnicalSkill(name: e)).toList(),
      );
      context.read<OnboardingCubit>().saveUserSkills(skills);
    }
  }
}
