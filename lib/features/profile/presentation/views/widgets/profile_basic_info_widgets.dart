import 'package:flutter/material.dart';
import '../../../../../../../core/utils/styles.dart';
import '../../../../../core/widgets/custom_text_filed.dart';
import '../../../../onboarding/presentation/views/widgets/custom_date_picker.dart';
import '../../../../onboarding/presentation/views/widgets/onboarding_user_basic_info/languages.dart';
import '../../../../../core/widgets/custom_button.dart';

class DateOfBirthField extends StatelessWidget {
  final TextEditingController controller;
  const DateOfBirthField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("تاريخ الميلاد", style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        CustomDatePicker(
          controller: controller,
          text: "تاريخ الميلاد",
        ),
      ],
    );
  }
}

class LocationField extends StatelessWidget {
  final TextEditingController controller;
  const LocationField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("الموقع", style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        CustomTextField(
          text: "الموقع",
          isPassword: false,
          controller: controller,
          hintText: "أدخل موقعك",
          prefixIcon: Icons.location_on,
          fillColor: Colors.white,
        ),
      ],
    );
  }
}

class GenderRadioGroup extends StatelessWidget {
  final String? gender;
  final ValueChanged<String?> onChanged;
  const GenderRadioGroup({super.key, required this.gender, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("الجنس", style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          textDirection: TextDirection.rtl,
          children: [
            Expanded(
              child: RadioListTile(
                title: const Text("ذكر"),
                value: "ذكر",
                groupValue: gender,
                onChanged: onChanged,
              ),
            ),
            Expanded(
              child: RadioListTile(
                title: const Text("أنثى"),
                value: "أنثى",
                groupValue: gender,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class LanguagesSection extends StatelessWidget {
  final List<String> languages;
  final void Function(String) removeLanguage;
  final VoidCallback addLanguage;
  final TextEditingController languageController;
  const LanguagesSection({
    super.key,
    required this.languages,
    required this.removeLanguage,
    required this.addLanguage,
    required this.languageController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("اللغات", style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Languages(
          languages: languages,
          removeLanguage: removeLanguage,
          addLanguage: addLanguage,
          languageController: languageController,
        ),
      ],
    );
  }
}

class SaveProfileButton extends StatelessWidget {
  final VoidCallback onPressed;
  const SaveProfileButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: onPressed,
      child: Text("حفظ", style: Styles.textStyle16.copyWith(color: Colors.white)),
    );
  }
}
