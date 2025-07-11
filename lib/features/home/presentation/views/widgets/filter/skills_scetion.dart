import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuhoud/core/utils/app_colors.dart';
import 'package:nuhoud/core/utils/styles.dart';
import 'package:nuhoud/core/widgets/custom_text_filed.dart';
import 'package:nuhoud/features/home/presentation/view-model/home_cubit/home_cubit.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "المهارات المطلوبة",
          style: Styles.textStyle16.copyWith(
            color: AppColors.headingTextColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        ...homeCubit.filterSkills.asMap().entries.map(
          (entry) {
            final index = entry.key;
            final skill = entry.value;
            final controller = TextEditingController(text: skill);
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      text: "المهارة ${index + 1}",
                      isPassword: false,
                      controller: controller,
                      onChange: (value) => homeCubit.updateSkill(index, value!),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => homeCubit.removeSkill(index),
                  ),
                ],
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: () => homeCubit.addSkill(),
            icon: const Icon(Icons.add, color: AppColors.primaryColor),
            label: Text(
              "إضافة مهارة",
              style: Styles.textStyle13.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
