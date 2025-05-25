import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/utils/routs.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/utils/validation.dart';
import '../../../../../../core/widgets/custom_snak_bar.dart';
import '../../../../../../core/widgets/custom_text_filed.dart';
import '../../../../data/model/experinces_model.dart';
import '../../../view-model/onboarding_cuibt/onboarding_cubit.dart';
import '../buttons_row.dart';
import '../onboarding_container.dart';
import '../custom_date_picker.dart';
import 'experince_form_item.dart';

class OnboardingUserExperiencePageBody extends StatefulWidget {
  const OnboardingUserExperiencePageBody({super.key});

  @override
  State<OnboardingUserExperiencePageBody> createState() =>
      _OnboardingUserExperiencePageBodyState();
}

class _OnboardingUserExperiencePageBodyState
    extends State<OnboardingUserExperiencePageBody> {
  final ExperinceFormItem formItem = ExperinceFormItem();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<ExperincesModel> addedExperiences = [];

  @override
  void dispose() {
    formItem.jobTitleController.dispose();
    formItem.companyController.dispose();
    formItem.jobDescriptionController.dispose();
    formItem.jobStartDateController.dispose();
    formItem.jobEndDateController.dispose();
    formItem.jobLocationController.dispose();
    super.dispose();
  }

  void addExperience() {
    final jobTitle = formItem.jobTitleController.text.trim();
    final company = formItem.companyController.text.trim();
    final jobDescription = formItem.jobDescriptionController.text.trim();
    final jobStartDate = formItem.jobStartDateController.text.trim();
    final jobEndDate = formItem.jobEndDateController.text.trim();
    final jobLocation = formItem.jobLocationController.text.trim();
    if (_formKey.currentState!.validate()) {
      setState(() {
        addedExperiences.add(ExperincesModel(
          jobTitle: jobTitle,
          company: company,
          jobDescription: jobDescription,
          jobStartDate: jobStartDate,
          jobEndDate: jobEndDate,
          jobLocation: jobLocation,
        ));
        formItem.clear();
      });
    }
  }

  void removeExperience(int index) {
    setState(() {
      addedExperiences.removeAt(index);
    });
  }

  void submitExperienceData() {
    if (addedExperiences.isEmpty) {
      CustomSnackBar.showSnackBar(
        contentType: ContentType.failure,
        message: "يرجى إضافة خبرة عمل",
        color: Colors.red,
        context: context,
        title: "",
        duration: const Duration(seconds: 2),
      );
    } else {
      final data = addedExperiences.map((e) => e.toJson()).toList();
      BlocProvider.of<OnboardingCubit>(context)
          .addBasicInfo("experiences", data);
      GoRouter.of(context).push(Routers.kOndboardingUserGoalsPage);
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
              "المستوى المهني",
              style: Styles.textStyle18.copyWith(color: AppColors.primaryColor),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ExperinceFormWidget(formItem: formItem, formKey: _formKey),
                  if (addedExperiences.isNotEmpty) const SizedBox(height: 10),
                  if (addedExperiences.isNotEmpty) ...[
                    Text("الخبرات المضافة:",
                        style: Styles.textStyle16
                            .copyWith(color: AppColors.primaryColor)),
                    const SizedBox(height: 10),
                    ...addedExperiences.asMap().entries.map((entry) {
                      final index = entry.key;
                      final exp = entry.value;
                      return Card(
                        color: AppColors.fillTextFiledColor,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          title: Text("${exp.jobTitle} - ${exp.company}"),
                          subtitle: Text(
                              "${exp.jobStartDate} | ${exp.jobEndDate} | الموقع: ${exp.jobLocation}"),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline_outlined,
                                color: Colors.red),
                            onPressed: () => removeExperience(index),
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
            primaryOnpressed: submitExperienceData,
            secondaryOnpressed: () => addExperience(),
            primaryText: "التالي",
            secondaryText: "إضافة خبرة",
          ),
        ],
      ),
    );
  }
}

class ExperinceFormWidget extends StatelessWidget {
  const ExperinceFormWidget(
      {super.key, required this.formItem, required this.formKey});
  final ExperinceFormItem formItem;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            text: "الوظيفة",
            isPassword: false,
            validatorFun: (val) =>
                Validator.validate(val, ValidationState.normal),
            hPadding: 0,
            controller: formItem.jobTitleController,
            fillColor: Colors.white,
            prefixIcon: Icons.work_outline,
          ),
          CustomTextField(
            text: "الشركة",
            isPassword: false,
            validatorFun: (val) =>
                Validator.validate(val, ValidationState.normal),
            hPadding: 0,
            controller: formItem.companyController,
            fillColor: Colors.white,
            prefixIcon: Icons.workspaces_outline,
          ),
          CustomTextField(
            text: "الوصف",
            isPassword: false,
            maxLine: 3,
            validatorFun: (val) =>
                Validator.validate(val, ValidationState.normal),
            hPadding: 0,
            controller: formItem.jobDescriptionController,
            fillColor: Colors.white,
            prefixIcon: Icons.description_outlined,
          ),
          CustomDatePicker(
            text: "سنة البدء",
            controller: formItem.jobStartDateController,
          ),
          CustomDatePicker(
            text: "سنة الانتهاء",
            controller: formItem.jobEndDateController,
          ),
        ],
      ),
    );
  }
}
