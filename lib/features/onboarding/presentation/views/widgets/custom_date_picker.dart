import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_constats.dart';
import '../../../../../core/utils/styles.dart';

class CustomDatePicker extends StatefulWidget {
  final TextEditingController controller;
  final String text;
  final String? Function(String?)? validatorFun;
  final bool allowPresent;

  const CustomDatePicker({
    super.key,
    required this.controller,
    required this.text,
    this.validatorFun,
    this.allowPresent = false,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  bool _isPresent = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black87,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
              ),
            ),
            datePickerTheme: DatePickerThemeData(
              backgroundColor: Colors.white,
              dayStyle: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
              todayBorder: const BorderSide(
                color: AppColors.primaryColor,
                width: 1.5,
              ),
              headerHelpStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              yearStyle: const TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
              dayForegroundColor: WidgetStateColor.resolveWith((states) {
                if (states.contains(WidgetState.disabled)) {
                  return Colors.grey;
                }
                return Colors.black;
              }),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      widget.controller.text =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    }
  }

  @override
  void initState() {
    super.initState();
    _isPresent = widget.controller.text == "حالياً";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(kBorderRadius)),
      padding: const EdgeInsets.only(top: 8),
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: widget.allowPresent
          ? Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: widget.controller,
                    readOnly: true,
                    onTap: _isPresent ? null : () => _selectDate(context),
                    enabled: !_isPresent,
                    style: Styles.textStyle16.copyWith(color: Colors.black87),
                    decoration: InputDecoration(
                      labelText: widget.text,
                      labelStyle: const TextStyle(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppColors.secondaryText,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(kBorderRadius),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppColors.secondaryText,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(kBorderRadius),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.calendar_today_outlined,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    validator: widget.validatorFun,
                  ),
                ),
                Checkbox(
                  value: _isPresent,
                  onChanged: (value) {
                    setState(() {
                      _isPresent = value!;
                      if (_isPresent) {
                        widget.controller.text = "حالياً";
                      } else {
                        widget.controller.text = "";
                      }
                    });
                  },
                ),
                const Text("حالياً"),
              ],
            )
          : TextFormField(
              controller: widget.controller,
              readOnly: true,
              onTap: () => _selectDate(context),
              style: Styles.textStyle16.copyWith(color: Colors.black87),
              decoration: InputDecoration(
                labelText: widget.text,
                labelStyle: const TextStyle(color: Colors.grey),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.secondaryText,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(kBorderRadius),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.secondaryText,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(kBorderRadius),
                ),
                fillColor: Colors.white,
                filled: true,
                prefixIcon: const Icon(
                  Icons.calendar_today_outlined,
                  color: AppColors.primaryColor,
                ),
              ),
              validator: widget.validatorFun,
            ),
    );
  }
}
