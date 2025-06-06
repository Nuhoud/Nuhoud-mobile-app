import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import '../onboarding_container.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/custom_snak_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/utils/routs.dart';
import '../../../../../../core/widgets/custom_dialog.dart';
import '../../../../data/model/certifications_model.dart';
import '../../../view-model/onboarding_cuibt/onboarding_cubit.dart';
import '../buttons_row.dart';
import 'certification_form_item.dart';
import 'certification_form_widget.dart';

class OnboardingUserCertificationsPageBody extends StatefulWidget {
  const OnboardingUserCertificationsPageBody({super.key});

  @override
  State<OnboardingUserCertificationsPageBody> createState() =>
      _OnboardingUserCertificationsPageBodyState();
}

class _OnboardingUserCertificationsPageBodyState
    extends State<OnboardingUserCertificationsPageBody> {
  final CertificationFormItem formItem = CertificationFormItem();
  final formKey = GlobalKey<FormState>();
  final List<CertificationsModel> addedCertifications = [];

  @override
  void dispose() {
    formItem.nameController.dispose();
    formItem.issueDateController.dispose();
    formItem.issuerController.dispose();
    super.dispose();
  }

  void addCertification() {
    if (formKey.currentState!.validate()) {
      final name = formItem.nameController.text.trim();
      final issueDate = formItem.issueDateController.text.trim();
      final issuer = formItem.issuerController.text.trim();
      setState(() {
        addedCertifications.add(CertificationsModel(
          name: name,
          issueDate: issueDate,
          issuer: issuer,
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

  void removeCertification(int index) {
    setState(() {
      addedCertifications.removeAt(index);
    });
  }

  void submitCertificationsData() {
    if (addedCertifications.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => CustomDialog(
          icon: Icons.warning_rounded,
          secondaryButtonText: "الغاء",
          title: "المتابعة بدون شهادة",
          description: "هل أنت متأكد من المتابعة بدون شهادة؟",
          onPrimaryAction: () {
            context.read<OnboardingCubit>().addBasicInfo("certifications", []);
            GoRouter.of(context).push(Routers.kOndboardingUserExperiencePage);
          },
          onSecondaryAction: () {
            GoRouter.of(context).pop();
          },
          primaryButtonText: "موافق",
        ),
      );
    } else {
      final data = addedCertifications.map((e) => e.toJson()).toList();
      context.read<OnboardingCubit>().addBasicInfo("certifications", data);
      GoRouter.of(context).push(Routers.kOndboardingUserExperiencePage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OnBoardingContainer(
      withFixedHight: false,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Text(
                "الشهادات العملية",
                style:
                    Styles.textStyle18.copyWith(color: AppColors.primaryColor),
              ),
            ),
            CertificationFormWidget(formItem: formItem, formKey: formKey),
            if (addedCertifications.isNotEmpty) const SizedBox(height: 10),
            if (addedCertifications.isNotEmpty) ...[
              Text("الشهادات المضافة:",
                  style: Styles.textStyle16
                      .copyWith(color: AppColors.primaryColor)),
              const SizedBox(height: 10),
              ...addedCertifications.asMap().entries.map((entry) {
                final index = entry.key;
                final cert = entry.value;
                return Card(
                  color: AppColors.fillTextFiledColor,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    title: Text(cert.name),
                    subtitle: Text("${cert.issuer} | ${cert.issueDate}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline_outlined,
                          color: Colors.red),
                      onPressed: () => removeCertification(index),
                    ),
                  ),
                );
              })
            ],
            const SizedBox(height: 10),
            ButtonsRow(
              primaryOnpressed: submitCertificationsData,
              secondaryOnpressed: () => addCertification(),
              primaryText: "التالي",
              secondaryText: "إضافة شهادة",
            ),
          ],
        ),
      ),
    );
  }
}
