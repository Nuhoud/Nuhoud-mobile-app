import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:nuhoud/core/utils/app_colors.dart';
import 'package:nuhoud/core/utils/app_constats.dart';
import 'package:nuhoud/core/utils/app_localizations.dart';
import 'package:nuhoud/core/utils/styles.dart';

class CustomPhoneField extends StatelessWidget {
  final Function(PhoneNumber) onChanged;
  const CustomPhoneField({super.key, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: IntlPhoneField(
        invalidNumberMessage: "الرقم المدخل غير صحيح",
        flagsButtonPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        showCountryFlag: false,
        showDropdownIcon: false,
        initialCountryCode: "SY",
        dropdownIconPosition: IconPosition.trailing,
        style: Styles.textStyle13.copyWith(
          color: AppColors.blackTextColor,
          fontWeight: FontWeight.w500,
        ),
        keyboardType: TextInputType.phone,
        onChanged: (value) {
          onChanged(value);
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          prefixIcon: const Icon(
            Icons.phone_iphone_outlined,
            color: AppColors.secodaryColor,
          ),
          hintStyle: Styles.textStyle13.copyWith(
            color: AppColors.secondaryText,
            fontWeight: FontWeight.w500,
          ),
          label: Text("phone_num".tr(context)),
          labelStyle: const TextStyle(
            color: AppColors.secondaryText,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.secondaryText,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.secondaryText,
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.secondaryText,
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.secondaryText,
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
        ),
      ),
    );
  }
}
