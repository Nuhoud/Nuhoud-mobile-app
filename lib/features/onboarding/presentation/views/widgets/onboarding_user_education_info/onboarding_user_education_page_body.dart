import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/routs.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/custom_dialog.dart';
import '../../../../../../core/widgets/custom_snak_bar.dart';
import '../../../../data/model/education_model.dart';
import '../../../view-model/onboarding_cuibt/onboarding_cubit.dart';
import '../buttons_row.dart';
import '../onboarding_container.dart';
import 'education_form_item.dart';
import 'education_form_widget.dart';

class OnboardingUserEducationPageBody extends StatefulWidget {
  const OnboardingUserEducationPageBody({super.key});

  @override
  State<OnboardingUserEducationPageBody> createState() => _OnboardingUserEducationPageBodyState();
}

class _OnboardingUserEducationPageBodyState extends State<OnboardingUserEducationPageBody> {
  final EducationFormItem formItem = EducationFormItem();
  final formKey = GlobalKey<FormState>();
  final List<EducationModel> addedDegrees = [];

  @override
  void dispose() {
    formItem.degreeController.dispose();
    formItem.fieldController.dispose();
    formItem.universityController.dispose();
    formItem.endYearController.dispose();
    formItem.gpaController.dispose();
    super.dispose();
  }

  void addDegree() {
    if (formKey.currentState!.validate()) {
      final degree = formItem.degreeController.text.trim();
      final field = formItem.fieldController.text.trim();
      final university = formItem.universityController.text.trim();
      final endYear = int.tryParse(formItem.endYearController.text.trim());
      final gpa = double.tryParse(formItem.gpaController.text.trim());
      setState(() {
        addedDegrees.add(EducationModel(
          degree: degree,
          field: field,
          university: university,
          endYear: endYear,
          gpa: gpa,
        ));
        formItem.clear();
      });
    } else {
      CustomSnackBar.showSnackBar(
        contentType: ContentType.failure,
        message: "يرجى ملء جميع الحقول المطلوبة",
        color: Colors.red,
        context: context,
        title: "",
        duration: const Duration(seconds: 2),
      );
    }
  }

  void removeDegree(int index) {
    setState(() {
      addedDegrees.removeAt(index);
    });
  }

  void submitEducationData() {
    if (addedDegrees.isEmpty) {
      showDialog(
          context: context,
          builder: (context) => CustomDialog(
                icon: Icons.warning_rounded,
                secondaryButtonText: "الغاء",
                title: "المتابعة بدون شهادة",
                description: "هل أنت متأكد من المتابعة بدون شهادة؟",
                onPrimaryAction: () {
                  context.read<OnboardingCubit>().addUserInfo("education", []);
                  GoRouter.of(context).push(Routers.kOndboardingUserCertificationsPage);
                },
                onSecondaryAction: () {
                  GoRouter.of(context).pop();
                },
                primaryButtonText: "موافق",
              ));
    } else {
      final data = addedDegrees.map((e) => e.toJson()).toList();
      context.read<OnboardingCubit>().addUserInfo("education", data);
      GoRouter.of(context).push(Routers.kOndboardingUserCertificationsPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OnBoardingContainer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Text(
              "المستوى التعليمي",
              style: Styles.textStyle18.copyWith(color: AppColors.primaryColor),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  EducationFormWidget(form: formItem, formKey: formKey),
                  if (addedDegrees.isNotEmpty) const SizedBox(height: 10),
                  if (addedDegrees.isNotEmpty) ...[
                    Text("الشهادات المضافة:", style: Styles.textStyle16.copyWith(color: AppColors.primaryColor)),
                    const SizedBox(height: 10),
                    ...addedDegrees.asMap().entries.map((entry) {
                      final index = entry.key;
                      final edu = entry.value;
                      return Card(
                        color: AppColors.fillTextFiledColor,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          title: Text("${edu.degree} - ${edu.field}"),
                          subtitle: Text("${edu.university} | ${edu.endYear} | ${edu.gpa}%"),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline_outlined, color: Colors.red),
                            onPressed: () => removeDegree(index),
                          ),
                        ),
                      );
                    })
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          ButtonsRow(
            primaryOnpressed: submitEducationData,
            secondaryOnpressed: () => addDegree(),
            primaryText: "التالي",
            secondaryText: "إضافة الشهادة",
          ),
        ],
      ),
    );
  }
}
