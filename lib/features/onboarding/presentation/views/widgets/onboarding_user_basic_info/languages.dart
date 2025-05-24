import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';

import '../../../../../../core/utils/styles.dart';

class Languages extends StatelessWidget {
  const Languages(
      {super.key,
      required this.languages,
      required this.removeLanguage,
      required this.addLanguage,
      required this.languageController});
  final List<String> languages;
  final Function(String) removeLanguage;
  final Function() addLanguage;
  final TextEditingController languageController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 8,
          children: languages
              .map((lang) => Chip(
                    label: Text(lang),
                    onDeleted: () => removeLanguage(lang),
                    backgroundColor:
                        AppColors.secodaryColor.withValues(alpha: 0.2),
                  ))
              .toList(),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: languageController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.language_outlined),
                  prefixIconColor: AppColors.primaryColor,
                  hintStyle: Styles.textStyle15.copyWith(
                    color: AppColors.secondaryText,
                  ),
                  hintText: "اللغات (العربية,الانجليزية,التركية...)",
                ),
              ),
            ),
            IconButton(
              onPressed: addLanguage,
              icon: const Icon(Icons.add_circle_outline_outlined,
                  color: AppColors.primaryColor),
            )
          ],
        ),
      ],
    );
  }
}
