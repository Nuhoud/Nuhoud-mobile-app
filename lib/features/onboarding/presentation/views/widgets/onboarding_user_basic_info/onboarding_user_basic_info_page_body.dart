import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nuhoud/core/widgets/custom_button.dart';
import 'package:nuhoud/core/widgets/custom_text_filed.dart';
import 'package:nuhoud/features/onboarding/presentation/view-model/onboarding_cuibt/onboarding_cubit.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/routs.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/custom_snak_bar.dart';
import '../custom_date_picker.dart';
import 'gender_drowp_down.dart';
import 'languages.dart';

class OnboardingUserBasicInfoPageBody extends StatefulWidget {
  const OnboardingUserBasicInfoPageBody({super.key});

  @override
  State<OnboardingUserBasicInfoPageBody> createState() =>
      _OnboardingUserBasicInfoPageBodyState();
}

class _OnboardingUserBasicInfoPageBodyState
    extends State<OnboardingUserBasicInfoPageBody> {
  String? gender;
  List<String> languages = [];
  late final TextEditingController locationController;
  late final TextEditingController languageController;
  late final TextEditingController dateController;

  @override
  void initState() {
    super.initState();
    locationController = TextEditingController();
    languageController = TextEditingController();
    dateController = TextEditingController();
  }

  @override
  void dispose() {
    locationController.dispose();
    languageController.dispose();
    dateController.dispose();
    languages.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("المعلومات الأساسية",
                  style: Styles.textStyle20.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor)),
              const SizedBox(height: 20),
              GenderDropdown(
                gender: gender,
                onChanged: (val) => setState(() => gender = val),
              ),
              const SizedBox(height: 20),
              CustomDatePicker(
                controller: dateController,
                text: "تاريخ الميلاد",
                validatorFun: (value) {
                  if (value == null || value.isEmpty) {
                    return "يرجى إدخال تاريخ الميلاد";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),
              CustomTextField(
                text: "الموقع",
                prefixIcon: Icons.location_on_outlined,
                controller: locationController,
                hintText: "سوريا, دمشق",
                isPassword: false,
                fillColor: Colors.white,
              ),
              const SizedBox(height: 16),
              Languages(
                languages: languages,
                removeLanguage: removeLanguage,
                addLanguage: addLanguage,
                languageController: languageController,
              ),
              const SizedBox(height: 20),
              CustomButton(
                  onPressed: () {
                    if (gender != null &&
                        dateController.text.isNotEmpty &&
                        locationController.text.isNotEmpty &&
                        languages.isNotEmpty) {
                      final data = {
                        "gender": gender,
                        "dateOfBirth":
                            parseDateFromController(dateController.text),
                        "location": locationController.text.trim(),
                        "languages": languages,
                      };
                      context
                          .read<OnboardingCubit>()
                          .addBasicInfo("basicInfo", data);

                      GoRouter.of(context)
                          .push(Routers.kOndboardingUserEducationPage);
                    } else {
                      CustomSnackBar.showSnackBar(
                        context: context,
                        title: "",
                        message: "الرجاء تعبئة جميع البيانات المطلوبة",
                        contentType: ContentType.failure,
                      );
                    }
                  },
                  child: Text(
                    "التالي",
                    style: Styles.textStyle16.copyWith(
                        color: AppColors.fillTextFiledColor,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  DateTime? parseDateFromController(String dateString) {
    try {
      final parts = dateString.split('-');
      if (parts.length != 3) return null;
      return DateTime(
        int.parse(parts[0]),
        int.parse(parts[1]),
        int.parse(parts[2]),
      );
    } catch (e) {
      return null;
    }
  }

  void addLanguage() {
    final text = languageController.text.trim();
    if (text.isNotEmpty && !languages.contains(text)) {
      setState(() {
        languages.add(text);
        languageController.clear();
      });
    }
  }

  void removeLanguage(String lang) {
    setState(() => languages.remove(lang));
  }
}
