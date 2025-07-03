import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/enums.dart';
import 'package:nuhoud/core/utils/validation.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/custom_dialog.dart';
import '../../../../../../core/widgets/custom_snak_bar.dart';
import '../../../../core/utils/size_app.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button.dart';

import '../../../../core/widgets/custom_text_filed.dart';
import '../../../onboarding/presentation/views/widgets/custom_date_picker.dart';
import '../../data/models/profile_model.dart';

class ProfileExperiencePage extends StatefulWidget {
  final List<Experience> initialExperiences;

  const ProfileExperiencePage({
    super.key,
    required this.initialExperiences,
  });

  @override
  State<ProfileExperiencePage> createState() => _ProfileExperiencePageState();
}

class _ProfileExperiencePageState extends State<ProfileExperiencePage> {
  late List<Experience> _experiences;
  int? _editingIndex;
  final _formKey = GlobalKey<FormState>();

  // Controllers for the form
  late TextEditingController _jobTitleController;
  late TextEditingController _companyController;
  late TextEditingController _locationController;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;
  late TextEditingController _descriptionController;
  bool _isCurrentJob = false;

  @override
  void initState() {
    super.initState();
    _experiences = List.from(widget.initialExperiences);
    _resetControllers();
  }

  void _resetControllers() {
    _jobTitleController = TextEditingController();
    _companyController = TextEditingController();
    _locationController = TextEditingController();
    _startDateController = TextEditingController();
    _endDateController = TextEditingController();
    _descriptionController = TextEditingController();
    _isCurrentJob = false;
  }

  void _populateControllers(Experience experience) {
    _jobTitleController.text = experience.jobTitle ?? '';
    _companyController.text = experience.company ?? '';
    _locationController.text = experience.location ?? '';
    _startDateController.text = experience.startDate ?? '';
    _isCurrentJob = experience.isCurrent ?? false;
    _endDateController.text = _isCurrentJob ? 'حالياً' : experience.endDate ?? '';
    _descriptionController.text = experience.description ?? '';
  }

  void _startEditing(int index) {
    setState(() {
      _editingIndex = index;
      _populateControllers(_experiences[index]);
    });
  }

  void _cancelEditing() {
    setState(() {
      _editingIndex = null;
      _resetControllers();
    });
  }

  void _saveExperience() {
    if (_formKey.currentState!.validate()) {
      final experience = Experience(
        jobTitle: _jobTitleController.text.trim(),
        company: _companyController.text.trim(),
        location: _locationController.text.trim(),
        startDate: _startDateController.text.trim(),
        isCurrent: _isCurrentJob,
        endDate: _isCurrentJob ? null : _endDateController.text.trim(),
        description: _descriptionController.text.trim(),
      );

      setState(() {
        if (_editingIndex != null) {
          _experiences[_editingIndex!] = experience;
        } else {
          _experiences.add(experience);
        }
        _editingIndex = null;
        _resetControllers();
      });
    }
  }

  void _deleteExperience(int index) {
    setState(() {
      _experiences.removeAt(index);
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
        title: "حذف الخبرة",
        description: "هل أنت متأكد أنك تريد حذف هذه الخبرة العملية؟",
        primaryButtonText: "حذف",
        secondaryButtonText: "إلغاء",
        onPrimaryAction: () {
          _deleteExperience(index);
          Navigator.pop(context);
        },
        onSecondaryAction: () => Navigator.pop(context),
      ),
    );
  }

  void _saveToBackend() {
    // TODO: Implement save to backend using Cubit/Bloc
    CustomSnackBar.showSnackBar(
      context: context,
      title: "تم الحفظ",
      message: "تم تحديث الخبرات العملية بنجاح",
      contentType: ContentType.success,
    );
  }

  @override
  void dispose() {
    _jobTitleController.dispose();
    _companyController.dispose();
    _locationController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(response(context, 60)),
          child: const CustomAppBar(
            backBtn: true,
            backgroundColor: AppColors.primaryColor,
            title: 'الخبرات العملية',
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Experience list title
              Text(
                "الخبرات العملية:",
                style: Styles.textStyle18.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 16),

              // Experience list
              if (_experiences.isEmpty) _buildEmptyState(),
              if (_experiences.isNotEmpty)
                ..._experiences.asMap().entries.map((entry) {
                  final index = entry.key;
                  final exp = entry.value;
                  return _buildExperienceItem(exp, index);
                }),
              const SizedBox(height: 24),

              if (_editingIndex != null) _buildExperienceForm(),

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

  Widget _buildExperienceForm() {
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
              _editingIndex == -1 ? "إضافة خبرة جديدة" : "تعديل الخبرة",
              style: Styles.textStyle16.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 16),

            // Job title field
            CustomTextField(
              controller: _jobTitleController,
              hintText: "المسمى الوظيفي",
              text: "المسمى الوظيفي",
              isPassword: false,
              validatorFun: (value) => Validator.validate(value, ValidationState.normal),
            ),
            const SizedBox(height: 16),

            // Company field
            CustomTextField(
                controller: _companyController,
                hintText: "اسم الشركة أو المؤسسة",
                text: "الشركة",
                isPassword: false,
                validatorFun: (value) => Validator.validate(value, ValidationState.normal)),
            const SizedBox(height: 16),

            // Location field
            CustomTextField(
              controller: _locationController,
              hintText: "موقع العمل",
              text: "الموقع",
              isPassword: false,
              validatorFun: (value) => Validator.validate(value, ValidationState.normal),
            ),
            const SizedBox(height: 16),

            // Start date
            CustomDatePicker(
              fillColor: AppColors.fillTextFiledColor,
              controller: _startDateController,
              text: "تاريخ البدء",
              validatorFun: (value) => Validator.validate(value, ValidationState.normal),
            ),
            const SizedBox(height: 16),

            // Current job checkbox
            CustomCheckbox(
              value: _isCurrentJob,
              onChanged: (value) {
                setState(() => _isCurrentJob = value!);
                if (value!) {
                  _endDateController.text = 'حالياً';
                }
              },
              title: "أنا أعمل في هذه الوظيفة حالياً",
            ),
            const SizedBox(height: 16),

            // End date (only if not current job)
            if (!_isCurrentJob)
              CustomDatePicker(
                fillColor: AppColors.fillTextFiledColor,
                controller: _endDateController,
                text: "تاريخ الانتهاء",
                validatorFun: (value) => Validator.validate(value, ValidationState.normal),
              ),
            if (!_isCurrentJob) const SizedBox(height: 16),

            // Description field
            CustomTextField(
              isPassword: false,
              controller: _descriptionController,
              hintText: "وصف الوظيفة والمهام",
              text: "الوصف",
              maxLine: 3,
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
                    onPressed: _saveExperience,
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

  Widget _buildExperienceItem(Experience experience, int index) {
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
          // Job title and company
          Text(
            "${experience.jobTitle} - ${experience.company}",
            style: Styles.textStyle16.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 8),

          // Location
          if (experience.location != null)
            Text(
              experience.location!,
              style: Styles.textStyle15.copyWith(color: AppColors.blackTextColor),
            ),

          // Dates
          Text(
            "${experience.startDate} - ${experience.isCurrent == true ? 'حالياً' : experience.endDate}",
            style: Styles.textStyle15,
          ),

          // Description if available
          if (experience.description != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                experience.description!,
                style: Styles.textStyle15.copyWith(color: AppColors.blackTextColor),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
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
          Icon(Icons.work, size: 60, color: AppColors.primaryColor.withOpacity(0.3)),
          const SizedBox(height: 16),
          Text(
            "لا توجد خبرات مضافة",
            style: Styles.textStyle16.copyWith(color: AppColors.blackTextColor),
          ),
          const SizedBox(height: 8),
          Text(
            "انقر على زر (+) لإضافة خبرة عملية",
            style: Styles.textStyle15.copyWith(color: AppColors.blackTextColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String title;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primaryColor,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: Styles.textStyle16.copyWith(color: AppColors.blackTextColor),
          textDirection: TextDirection.rtl,
        ),
      ],
    );
  }
}
