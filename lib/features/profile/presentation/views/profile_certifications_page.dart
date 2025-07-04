import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/app_colors.dart';
import 'package:nuhoud/core/utils/enums.dart';
import 'package:nuhoud/core/utils/styles.dart';
import 'package:nuhoud/core/utils/validation.dart';
import 'package:nuhoud/core/widgets/custom_dialog.dart';
import 'package:nuhoud/core/widgets/custom_snak_bar.dart';
import 'package:nuhoud/core/widgets/custom_app_bar.dart';
import 'package:nuhoud/core/widgets/custom_button.dart';
import 'package:nuhoud/core/widgets/custom_text_filed.dart';
import 'package:nuhoud/core/utils/size_app.dart';
import 'package:nuhoud/features/onboarding/presentation/views/widgets/custom_date_picker.dart';
import 'package:nuhoud/features/profile/data/models/profile_model.dart';

class ProfileCertificationPage extends StatefulWidget {
  final List<Certification> initialCertifications;

  const ProfileCertificationPage({
    super.key,
    required this.initialCertifications,
  });

  @override
  State<ProfileCertificationPage> createState() => _ProfileCertificationPageState();
}

class _ProfileCertificationPageState extends State<ProfileCertificationPage> {
  late List<Certification> _certifications;
  int? _editingIndex;
  final _formKey = GlobalKey<FormState>();

  // Controllers for the form
  late TextEditingController _nameController;
  late TextEditingController _issuerController;
  late TextEditingController _issueDateController;

  @override
  void initState() {
    super.initState();
    _certifications = List.from(widget.initialCertifications);
    _resetControllers();
  }

  void _resetControllers() {
    _nameController = TextEditingController();
    _issuerController = TextEditingController();
    _issueDateController = TextEditingController();
  }

  void _populateControllers(Certification certification) {
    _nameController.text = certification.name ?? '';
    _issuerController.text = certification.issuer ?? '';
    _issueDateController.text = certification.issueDate ?? '';
  }

  void _startEditing(int index) {
    setState(() {
      _editingIndex = index;
      _populateControllers(_certifications[index]);
    });
  }

  void _cancelEditing() {
    setState(() {
      _editingIndex = null;
      _resetControllers();
    });
  }

  void _saveCertification() {
    if (_formKey.currentState!.validate()) {
      final certification = Certification(
        name: _nameController.text.trim(),
        issuer: _issuerController.text.trim(),
        issueDate: _issueDateController.text.trim(),
      );

      setState(() {
        if (_editingIndex != null) {
          _certifications[_editingIndex!] = certification;
        } else {
          _certifications.add(certification);
        }
        _editingIndex = null;
        _resetControllers();
      });
    }
  }

  void _deleteCertification(int index) {
    setState(() {
      _certifications.removeAt(index);
      if (_editingIndex == index) {
        _editingIndex = null;
        _resetControllers();
      }
    });
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        icon: Icons.warning_rounded,
        title: "حذف الشهادة",
        description: "هل أنت متأكد أنك تريد حذف هذه الشهادة؟",
        primaryButtonText: "حذف",
        secondaryButtonText: "إلغاء",
        onPrimaryAction: () {
          _deleteCertification(index);
          Navigator.pop(context);
        },
        onSecondaryAction: () => Navigator.pop(context),
      ),
    );
  }

  void _saveToBackend() {
    // TODO: Implement save to backend
    CustomSnackBar.showSnackBar(
      context: context,
      title: "تم الحفظ",
      message: "تم تحديث الشهادات بنجاح",
      contentType: ContentType.success,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _issuerController.dispose();
    _issueDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(response(context, 60)),
          child: const CustomAppBar(
            backBtn: true,
            backgroundColor: AppColors.primaryColor,
            title: 'الشهادات',
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Certifications list title
              Text(
                "الشهادات:",
                style: Styles.textStyle18.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 16),

              // Certifications list
              if (_certifications.isEmpty) _buildEmptyState(),
              if (_certifications.isNotEmpty)
                ..._certifications.asMap().entries.map((entry) {
                  final index = entry.key;
                  final cert = entry.value;
                  return _buildCertificationItem(cert, index);
                }),
              const SizedBox(height: 24),

              if (_editingIndex != null) _buildCertificationForm(),

              const SizedBox(height: 30),

              // Save all button
              CustomButton(
                onPressed: _saveToBackend,
                child: Text(
                  "حفظ التغييرات",
                  style: Styles.textStyle16.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: _editingIndex == null
            ? FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _editingIndex = -1; // Special value for new item
                    _resetControllers();
                  });
                },
                backgroundColor: AppColors.primaryColor,
                child: const Icon(Icons.add, color: Colors.white),
              )
            : null,
      ),
    );
  }

  Widget _buildCertificationForm() {
    return Form(
      key: _formKey,
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
              _editingIndex == -1 ? "إضافة شهادة جديدة" : "تعديل الشهادة",
              style: Styles.textStyle16.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 16),

            // Certification name field
            CustomTextField(
              controller: _nameController,
              hintText: "اسم الشهادة",
              text: "اسم الشهادة",
              isPassword: false,
              validatorFun: (value) => Validator.validate(value, ValidationState.normal),
            ),
            const SizedBox(height: 16),

            // Issuer field
            CustomTextField(
              controller: _issuerController,
              hintText: "الجهة المانحة",
              text: "الجهة المانحة",
              isPassword: false,
              validatorFun: (value) => Validator.validate(value, ValidationState.normal),
            ),
            const SizedBox(height: 16),

            // Issue date
            CustomDatePicker(
              fillColor: AppColors.fillTextFiledColor,
              controller: _issueDateController,
              text: "تاريخ الإصدار",
              validatorFun: (value) => Validator.validate(value, ValidationState.normal),
            ),
            const SizedBox(height: 20),

            // Form buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _cancelEditing,
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
                    onPressed: _saveCertification,
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

  Widget _buildCertificationItem(Certification certification, int index) {
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
          // Certification name and issuer
          Text(
            certification.name ?? '',
            style: Styles.textStyle16.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 8),

          // Issuer
          if (certification.issuer != null)
            Text(
              certification.issuer!,
              style: Styles.textStyle15.copyWith(color: AppColors.blackTextColor),
            ),

          // Issue date
          if (certification.issueDate != null)
            Text(
              certification.issueDate!,
              style: Styles.textStyle15,
            ),

          // Edit/delete buttons
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: AppColors.primaryColor),
                  onPressed: () => _startEditing(index),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _confirmDelete(index),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
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
