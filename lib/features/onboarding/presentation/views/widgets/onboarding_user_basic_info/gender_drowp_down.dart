import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_constats.dart';

class GenderDropdown extends StatelessWidget {
  const GenderDropdown(
      {super.key, required this.gender, required this.onChanged});
  final String? gender;
  final ValueChanged<String?> onChanged;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      dropdownColor: Colors.white,
      value: gender,
      hint: const Text("اختر الجنس"),
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.male_outlined,
          color: AppColors.primaryColor,
        ),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.secondaryText,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.secondaryText,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
      ),
      items: ['ذكر', 'أنثى']
          .map((g) => DropdownMenuItem(
                value: g == 'ذكر' ? 'male' : 'female',
                child: Text(g),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }
}
