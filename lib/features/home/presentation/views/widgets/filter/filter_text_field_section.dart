import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/app_colors.dart';
import 'package:nuhoud/core/utils/styles.dart';
import 'package:nuhoud/core/widgets/custom_text_filed.dart';

class FilterTextFieldSection extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final Function(String?)? onChanged;
  final TextInputType keyboardType;

  const FilterTextFieldSection({
    super.key,
    required this.title,
    required this.hint,
    required this.controller,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Styles.textStyle16.copyWith(
            color: AppColors.headingTextColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        CustomTextField(
          text: hint,
          isPassword: false,
          keyboardType: keyboardType,
          controller: controller,
          onChange: onChanged,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
