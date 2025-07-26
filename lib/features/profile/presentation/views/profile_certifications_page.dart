import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuhoud/core/utils/app_colors.dart';
import 'package:nuhoud/core/utils/styles.dart';
import 'package:nuhoud/core/widgets/custom_dialog.dart';
import 'package:nuhoud/core/widgets/custom_snak_bar.dart';
import 'package:nuhoud/core/widgets/custom_app_bar.dart';
import 'package:nuhoud/core/widgets/custom_button.dart';
import 'package:nuhoud/core/utils/size_app.dart';
import 'package:nuhoud/features/profile/data/models/profile_model.dart';
import 'package:nuhoud/features/profile/presentation/view-model/cubit/profile_cubit.dart';
import 'widgets/profile_certifications_widgets.dart';

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
  int? _editingIndex; // null = no editing, -1 = adding new
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
        if (_editingIndex != null && _editingIndex! >= 0) {
          // Update existing certification
          _certifications[_editingIndex!] = certification;
        } else {
          // Add new certification
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
    if (context.read<ProfileCubit>().profile != null) {
      final profile = context.read<ProfileCubit>().profile!;
      final updatedProfile = ProfileModel(
        basicInfo: profile.basicInfo,
        education: profile.education,
        experiences: profile.experiences,
        certifications: _certifications,
        jobPreferences: profile.jobPreferences,
        goals: profile.goals,
        skills: profile.skills,
      );
      context.read<ProfileCubit>().updateProfile(updatedProfile);
    }
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
              if (_certifications.isEmpty) const CertificationsEmptyState(),
              if (_certifications.isNotEmpty)
                ..._certifications.asMap().entries.map((entry) {
                  final index = entry.key;
                  final cert = entry.value;
                  return CertificationItem(
                    certification: cert,
                    index: index,
                    onEdit: () => _startEditing(index),
                    onDelete: () => _confirmDelete(index),
                  );
                }),
              const SizedBox(height: 24),

              // Show form when adding new or editing existing
              if (_editingIndex != null)
                CertificationForm(
                  formKey: _formKey,
                  nameController: _nameController,
                  issuerController: _issuerController,
                  issueDateController: _issueDateController,
                  onCancel: _cancelEditing,
                  onSave: _saveCertification,
                  isEditing: _editingIndex != -1, // True if editing, false if adding new
                ),

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
                      message: "تم تحديث الشهادات بنجاح",
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
}
