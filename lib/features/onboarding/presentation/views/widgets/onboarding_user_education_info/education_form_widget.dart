import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_constats.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/utils/validation.dart';
import '../../../../../../core/widgets/custom_text_filed.dart';
import 'education_form_item.dart';

class EducationFormWidget extends StatelessWidget {
  final EducationFormItem form;
  final GlobalKey<FormState> formKey;
  const EducationFormWidget({
    super.key,
    required this.form,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 18, vertical: kVerticalPadding),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextField(
              text: "الشهادة العلمية",
              isPassword: false,
              validatorFun: (val) =>
                  Validator.validate(val, ValidationState.normal),
              hPadding: 0,
              controller: form.degreeController,
              fillColor: Colors.white,
              prefixIcon: Icons.school_outlined,
            ),
            CustomTextField(
              text: "التخصص",
              isPassword: false,
              validatorFun: (val) =>
                  Validator.validate(val, ValidationState.normal),
              hPadding: 0,
              controller: form.fieldController,
              fillColor: Colors.white,
              prefixIcon: Icons.work_outline,
            ),
            CustomTextField(
              text: "الجامعة او المدرسة",
              isPassword: false,
              validatorFun: (val) =>
                  Validator.validate(val, ValidationState.normal),
              hPadding: 0,
              controller: form.universityController,
              fillColor: Colors.white,
              prefixIcon: Icons.location_city_outlined,
            ),
            CustomTextField(
              text: "سنة التخرج",
              isPassword: false,
              validatorFun: (val) =>
                  Validator.validate(val, ValidationState.price),
              hPadding: 0,
              controller: form.endYearController,
              fillColor: Colors.white,
              prefixIcon: Icons.date_range,
              keyboardType: TextInputType.number,
            ),
            CustomTextField(
              text: "المعدل التراكمي (GPA)",
              isPassword: false,
              keyboardType: TextInputType.number,
              validatorFun: (val) =>
                  Validator.validate(val, ValidationState.price),
              hPadding: 0,
              controller: form.gpaController,
              fillColor: Colors.white,
              prefixIcon: Icons.percent,
            ),
          ],
        ),
      ),
    );
  }
}
