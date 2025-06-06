import 'package:flutter/material.dart';
import '../../../../../../core/utils/validation.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/widgets/custom_text_filed.dart';
import '../custom_date_picker.dart';
import 'certification_form_item.dart';

class CertificationFormWidget extends StatelessWidget {
  final CertificationFormItem formItem;
  final GlobalKey<FormState> formKey;
  const CertificationFormWidget(
      {super.key, required this.formItem, required this.formKey});
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            text: "اسم الشهادة",
            isPassword: false,
            validatorFun: (val) =>
                Validator.validate(val, ValidationState.normal),
            hPadding: 0,
            controller: formItem.nameController,
            fillColor: Colors.white,
            prefixIcon: Icons.card_membership_outlined,
          ),
          CustomDatePicker(
            text: "تاريخ الاصدار",
            controller: formItem.issueDateController,
            validatorFun: (val) =>
                Validator.validate(val, ValidationState.normal),
          ),
          CustomTextField(
            text: "الجهة المانحة",
            isPassword: false,
            validatorFun: (val) =>
                Validator.validate(val, ValidationState.normal),
            hPadding: 0,
            controller: formItem.issuerController,
            fillColor: Colors.white,
            prefixIcon: Icons.business_outlined,
          ),
        ],
      ),
    );
  }
}
