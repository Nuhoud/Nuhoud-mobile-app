import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuhoud/core/utils/enums.dart';
import 'package:nuhoud/core/utils/validation.dart';
import 'package:nuhoud/features/profile/data/models/profile_model.dart';
import 'package:nuhoud/features/profile/presentation/view-model/cubit/profile_cubit.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/custom_dialog.dart';
import '../../../../../../core/widgets/custom_snak_bar.dart';
import '../../../../core/utils/size_app.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_filed.dart';

class ProfileEducationPage extends StatefulWidget {
  final List<Education> initialEducations;

  const ProfileEducationPage({
    super.key,
    required this.initialEducations,
  });

  @override
  State<ProfileEducationPage> createState() => _ProfileEducationPageState();
}

class _ProfileEducationPageState extends State<ProfileEducationPage> {
  late List<Education> _educations;
  int? _editingIndex;
  final _formKey = GlobalKey<FormState>();

  // Controllers for the form
  late TextEditingController _degreeController;
  late TextEditingController _fieldController;
  late TextEditingController _universityController;
  late TextEditingController _endYearController;
  late TextEditingController _gpaController;

  @override
  void initState() {
    super.initState();
    _educations = List.from(widget.initialEducations);
    _resetControllers();
  }

  void _resetControllers() {
    _degreeController = TextEditingController();
    _fieldController = TextEditingController();
    _universityController = TextEditingController();
    _endYearController = TextEditingController();
    _gpaController = TextEditingController();
  }

  void _populateControllers(Education education) {
    _degreeController.text = education.degree ?? '';
    _fieldController.text = education.field ?? '';
    _universityController.text = education.university ?? '';
    _endYearController.text = education.endYear?.toString() ?? '';
    _gpaController.text = education.gpa?.toString() ?? '';
  }

  void _startEditing(int index) {
    setState(() {
      _editingIndex = index;
      _populateControllers(_educations[index]);
    });
  }

  void _cancelEditing() {
    setState(() {
      _editingIndex = null;
      _resetControllers();
    });
  }

  void _saveEducation() {
    if (_formKey.currentState!.validate()) {
      final education = Education(
        degree: _degreeController.text.trim(),
        field: _fieldController.text.trim(),
        university: _universityController.text.trim(),
        endYear: int.tryParse(_endYearController.text.trim()),
        gpa: double.tryParse(_gpaController.text.trim()),
      );

      setState(() {
        if (_editingIndex != null && _editingIndex! >= 0) {
          _educations[_editingIndex!] = education;
        } else {
          _educations.add(education);
        }
        _editingIndex = null;
        _resetControllers();
      });
    }
  }

  void _deleteEducation(int index) {
    setState(() {
      _educations.removeAt(index);
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
        title: "حذف المؤهل",
        description: "هل أنت متأكد أنك تريد حذف هذا المؤهل التعليمي؟",
        primaryButtonText: "حذف",
        secondaryButtonText: "إلغاء",
        onPrimaryAction: () {
          _deleteEducation(index);
          Navigator.pop(context);
        },
        onSecondaryAction: () => Navigator.pop(context),
      ),
    );
  }

  void _saveToBackend() {
    final cubit = context.read<ProfileCubit>();
    final currentProfile = cubit.profile;
    if (currentProfile != null) {
      final updatedProfile = ProfileModel(
        basicInfo: currentProfile.basicInfo,
        education: _educations, // 🔁 Updated education list
        experiences: currentProfile.experiences,
        certifications: currentProfile.certifications,
        jobPreferences: currentProfile.jobPreferences,
        goals: currentProfile.goals,
        skills: currentProfile.skills,
      );
      cubit.updateProfile(updatedProfile); // 🔄 Calls Cubit's update method
    }
  }

  @override
  void dispose() {
    _degreeController.dispose();
    _fieldController.dispose();
    _universityController.dispose();
    _endYearController.dispose();
    _gpaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SafeArea(
            child: CustomAppBar(
              backBtn: true,
              backgroundColor: AppColors.primaryColor,
              title: 'المؤهلات التعليمية',
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Education list title
                  Text(
                    "المؤهلات المضافة:",
                    style: Styles.textStyle18.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Education list
                  if (_educations.isEmpty) _buildEmptyState(),
                  if (_educations.isNotEmpty)
                    ..._educations.asMap().entries.map((entry) {
                      final index = entry.key;
                      final edu = entry.value;
                      return _buildEducationItem(edu, index);
                    }),
                  const SizedBox(height: 24),
                  // Education form (visible when adding/editing)
                  if (_editingIndex != null) _buildEducationForm(),
                  const SizedBox(height: 30),
                  // Save all button
                  BlocConsumer<ProfileCubit, ProfileState>(
                    listener: (context, state) {
                      if (state is UpdateProfileSuccess) {
                        Navigator.pop(context);
                        context.read<ProfileCubit>().getProfile();
                        CustomSnackBar.showSnackBar(
                          context: context,
                          title: "تم الحفظ",
                          message: "تم تحديث المؤهلات التعليمية بنجاح",
                          contentType: ContentType.success,
                        );
                      }
                      if (state is UpdateProfileError) {
                        CustomSnackBar.showSnackBar(
                          context: context,
                          title: "خطأ",
                          message: state.message,
                          contentType: ContentType.failure,
                        );
                      }
                    },
                    builder: (context, state) {
                      return CustomButton(
                        isLoading: state is UpdateProfileLoading,
                        onPressed: _saveToBackend,
                        child: Text(
                          "حفظ التغييرات",
                          style: Styles.textStyle16.copyWith(color: Colors.white),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
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
    );
  }

  Widget _buildEducationForm() {
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
              _editingIndex == -1 ? "إضافة مؤهل جديد" : "تعديل المؤهل",
              style: Styles.textStyle16.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            // Degree field
            CustomTextField(
              controller: _degreeController,
              hintText: "المؤهل العلمي (مثل: بكالوريوس)",
              text: "المؤهل العلمي",
              isPassword: false,
              validatorFun: (text) => Validator.validate(text, ValidationState.normal),
            ),
            const SizedBox(height: 16),
            // Field of study
            CustomTextField(
              controller: _fieldController,
              hintText: "التخصص (مثل: هندسة برمجيات)",
              text: "التخصص",
              isPassword: false,
              validatorFun: (text) => Validator.validate(text, ValidationState.normal),
            ),
            const SizedBox(height: 16),
            // University
            CustomTextField(
              controller: _universityController,
              hintText: "الجامعة أو المؤسسة التعليمية",
              text: "الجامعة",
              isPassword: false,
              validatorFun: (text) => Validator.validate(text, ValidationState.normal),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                // End Year
                Expanded(
                  child: CustomTextField(
                    controller: _endYearController,
                    isPassword: false,
                    hintText: "سنة التخرج",
                    text: "سنة التخرج",
                    keyboardType: TextInputType.number,
                    validatorFun: (value) {
                      if (value == null || value.isEmpty) {
                        return "الرجاء إدخال سنة التخرج";
                      }
                      final year = int.tryParse(value);
                      if (year == null || year < 1900 || year > DateTime.now().year + 5) {
                        return "سنة غير صالحة";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                // GPA
                Expanded(
                  child: CustomTextField(
                    controller: _gpaController,
                    hintText: "المعدل التراكمي",
                    text: "المعدل",
                    isPassword: false,
                    keyboardType: TextInputType.number,
                    validatorFun: (value) {
                      if (value == null || value.isEmpty) return null;
                      final gpa = double.tryParse(value);
                      if (gpa == null || gpa < 0 || gpa > 100) {
                        return "معدل غير صالح";
                      }
                      return null;
                    },
                  ),
                ),
              ],
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
                    onPressed: _saveEducation,
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

  Widget _buildEducationItem(Education education, int index) {
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
          // Degree and field
          Text(
            "${education.degree} - ${education.field}",
            style: Styles.textStyle16.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          // University and year
          Text(
            "${education.university} | ${education.endYear}",
            style: Styles.textStyle15,
          ),
          // GPA if available
          if (education.gpa != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                "المعدل: ${education.gpa}",
                style: Styles.textStyle15,
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
          Icon(Icons.school, size: 60, color: AppColors.primaryColor.withOpacity(0.3)),
          const SizedBox(height: 16),
          Text(
            "لا توجد مؤهلات مضافة",
            style: Styles.textStyle16.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            "انقر على زر (+) لإضافة مؤهل تعليمي",
            style: Styles.textStyle15.copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
