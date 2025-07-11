import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/app_colors.dart';
import 'package:nuhoud/core/utils/styles.dart';
import 'package:nuhoud/core/widgets/custom_drop_dpown_button.dart';

class FilterDropdownSection extends StatelessWidget {
  final String title;
  final String hint;
  final List<String> items;
  final String? value;
  final Function(String?) onChanged;

  const FilterDropdownSection({
    super.key,
    required this.title,
    required this.hint,
    required this.items,
    required this.value,
    required this.onChanged,
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
        CustomDropdownButton(
          text: hint,
          items: items,
          value: value,
          onChanged: onChanged,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
