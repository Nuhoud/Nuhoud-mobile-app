import 'package:flutter/material.dart';

import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/utils/validation.dart';
import '../../../../../../core/widgets/custom_text_filed.dart';
import '../custom_date_picker.dart';
import 'experince_form_item.dart';

class ExperinceFormWidget extends StatelessWidget {
  const ExperinceFormWidget({super.key, required this.formItem, required this.formKey});
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
            validatorFun: (val) => Validator.validate(val, ValidationState.normal),
            hPadding: 0,
            controller: formItem.jobTitleController,
            fillColor: Colors.white,
            prefixIcon: Icons.business_center_outlined,
          ),
          CustomTextField(
            text: "اسم الشركة",
            isPassword: false,
            validatorFun: (val) => Validator.validate(val, ValidationState.normal),
            hPadding: 0,
            controller: formItem.companyController,
            fillColor: Colors.white,
            prefixIcon: Icons.business_outlined,
          ),
          CustomTextField(
            text: "مكان العمل",
            isPassword: false,
            validatorFun: (val) => Validator.validate(val, ValidationState.normal),
            hPadding: 0,
            controller: formItem.jobLocationController,
            fillColor: Colors.white,
            prefixIcon: Icons.location_on_outlined,
          ),
          CustomTextField(
            text: "وصف الوظيفة",
            isPassword: false,
            maxLine: 3,
            validatorFun: (val) => Validator.validate(val, ValidationState.normal),
            hPadding: 0,
            controller: formItem.jobDescriptionController,
            fillColor: Colors.white,
            prefixIcon: Icons.description_outlined,
          ),
          CustomDatePicker(
            text: "تاريخ البدء",
            controller: formItem.jobStartDateController,
          ),
          CustomDatePicker(
            text: "تاريخ الانتهاء",
            controller: formItem.jobEndDateController,
            allowPresent: true,
          ),
        ],
      ),
    );
  }
}
