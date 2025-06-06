import 'package:flutter/material.dart';
import '../../../../../core/utils/styles.dart';
import '../utils/app_colors.dart';
import '../utils/app_constats.dart';

class CustomDropdownButton extends StatelessWidget {
  final String text;
  final String? value;
  final Function(String?) onChanged;
  final List<String> items;
  final String? Function(String?)? validator;
  final List<String>? selectedItems;

  const CustomDropdownButton({
    super.key,
    required this.text,
    required this.items,
    required this.value,
    required this.onChanged,
    this.validator,
    this.selectedItems,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xffF4F7FE),
          borderRadius: BorderRadius.circular(kBorderRadius)),
      padding: const EdgeInsets.only(top: 8),
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: DropdownButtonFormField<String>(
        dropdownColor: Colors.white,
        decoration: InputDecoration(
          labelText: text,
          labelStyle: const TextStyle(color: Colors.grey),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
            borderSide: BorderSide.none,
          ),
          fillColor: const Color(0xffF4F7FE),
          filled: true,
        ),
        items: items.map((value) {
          final isSelected = selectedItems?.contains(value) ?? false;
          return DropdownMenuItem<String>(
            value: value,
            child: Row(
              children: [
                Text(value),
                if (isSelected) ...[
                  const SizedBox(width: 8),
                  const Icon(Icons.check,
                      color: AppColors.primaryColor, size: 18),
                ]
              ],
            ),
          );
        }).toList(),
        onChanged: onChanged,
        validator: validator,
        icon: const Icon(Icons.arrow_drop_down),
        style: Styles.textStyle16.copyWith(color: Colors.black87),
      ),
    );
  }
}
