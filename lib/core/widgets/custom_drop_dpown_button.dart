import 'package:flutter/material.dart';
import '../../../../../core/utils/styles.dart';
import '../utils/app_colors.dart';
import '../utils/app_constats.dart';

class CustomDropdownButton<T> extends StatelessWidget {
  final String text;
  final T? value;
  final Function(T?) onChanged;
  final List<T> items;
  final String? Function(T?)? validator;
  final List<T>? selectedItems;
  final String Function(T)? itemToString;

  const CustomDropdownButton({
    super.key,
    required this.text,
    required this.items,
    required this.value,
    required this.onChanged,
    this.validator,
    this.selectedItems,
    this.itemToString,
  });

  String _getItemText(T item) {
    if (itemToString != null) return itemToString!(item);
    if (item is String) return item;
    return item.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffF4F7FE),
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      padding: const EdgeInsets.only(top: 8),
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: DropdownButtonFormField<T>(
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
        items: items.map((item) {
          final isSelected = selectedItems != null && selectedItems!.contains(item);
          return DropdownMenuItem<T>(
            value: item,
            child: Row(
              children: [
                Text(_getItemText(item)),
                if (isSelected) ...[
                  const SizedBox(width: 8),
                  const Icon(Icons.check, color: AppColors.primaryColor, size: 18),
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
