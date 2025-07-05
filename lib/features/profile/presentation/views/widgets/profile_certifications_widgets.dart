import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/app_colors.dart';
import 'package:nuhoud/core/utils/styles.dart';
import 'package:nuhoud/core/widgets/custom_button.dart';
import 'package:nuhoud/core/widgets/custom_text_filed.dart';
import 'package:nuhoud/features/onboarding/presentation/views/widgets/custom_date_picker.dart';
import 'package:nuhoud/core/utils/validation.dart';
import 'package:nuhoud/core/utils/enums.dart';
import 'package:nuhoud/features/profile/data/models/profile_model.dart';

class CertificationsEmptyState extends StatelessWidget {
  const CertificationsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: AppColors.fillTextFiledColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(Icons.card_membership, size: 60, color: AppColors.primaryColor.withOpacity(0.3)),
          const SizedBox(height: 16),
          Text(
            "لا توجد شهادات مضافة",
            style: Styles.textStyle16.copyWith(color: AppColors.blackTextColor),
          ),
          const SizedBox(height: 8),
          Text(
            "انقر على زر (+) لإضافة شهادة جديدة",
            style: Styles.textStyle15.copyWith(color: AppColors.blackTextColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class CertificationItem extends StatelessWidget {
  final Certification certification;
  final int index;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const CertificationItem({
    super.key,
    required this.certification,
    required this.index,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            certification.name ?? '',
            style: Styles.textStyle16.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          if (certification.issuer != null)
            Text(
              certification.issuer!,
              style: Styles.textStyle15.copyWith(color: AppColors.blackTextColor),
            ),
          if (certification.issueDate != null)
            Text(
              certification.issueDate!,
              style: Styles.textStyle15,
            ),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: AppColors.primaryColor),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CertificationForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController issuerController;
  final TextEditingController issueDateController;
  final VoidCallback onCancel;
  final VoidCallback onSave;
  final bool isEditing;
  const CertificationForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.issuerController,
    required this.issueDateController,
    required this.onCancel,
    required this.onSave,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primaryColor.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isEditing ? "تعديل الشهادة" : "إضافة شهادة جديدة",
              style: Styles.textStyle16.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: nameController,
              hintText: "اسم الشهادة",
              text: "اسم الشهادة",
              isPassword: false,
              validatorFun: (value) => Validator.validate(value, ValidationState.normal),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: issuerController,
              hintText: "الجهة المانحة",
              text: "الجهة المانحة",
              isPassword: false,
              validatorFun: (value) => Validator.validate(value, ValidationState.normal),
            ),
            const SizedBox(height: 16),
            CustomDatePicker(
              fillColor: AppColors.fillTextFiledColor,
              controller: issueDateController,
              text: "تاريخ الإصدار",
              validatorFun: (value) => Validator.validate(value, ValidationState.normal),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onCancel,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: AppColors.primaryColor),
                    ),
                    child: Text(
                      "إلغاء",
                      style: Styles.textStyle16.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomButton(
                    onPressed: onSave,
                    child: Text(
                      "حفظ",
                      style: Styles.textStyle16.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
