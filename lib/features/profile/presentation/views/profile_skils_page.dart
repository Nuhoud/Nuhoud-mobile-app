import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuhoud/core/utils/app_colors.dart';
import 'package:nuhoud/core/utils/styles.dart';
import 'package:nuhoud/core/widgets/custom_app_bar.dart';
import 'package:nuhoud/core/widgets/custom_button.dart';
import 'package:nuhoud/core/widgets/custom_drop_dpown_button.dart';
import 'package:nuhoud/core/widgets/custom_snak_bar.dart';
import 'package:nuhoud/features/profile/data/models/profile_model.dart';
import 'package:nuhoud/features/profile/presentation/view-model/cubit/profile_cubit.dart';

class ProfileSkillsPage extends StatefulWidget {
  final Skills initialSkills;

  const ProfileSkillsPage({
    super.key,
    required this.initialSkills,
  });

  @override
  State<ProfileSkillsPage> createState() => _ProfileSkillsPageState();
}

class _ProfileSkillsPageState extends State<ProfileSkillsPage> {
  late Skills _skills;
  Skills allSkills = Skills(
    softSkills: [
      TechnicalSkill(name: "مهارات1", level: 1),
      TechnicalSkill(name: "مهارات 2", level: 2),
    ],
    technicalSkills: [
      TechnicalSkill(name: "مهارات1", level: 1),
      TechnicalSkill(name: "مهارات 2", level: 2),
    ],
  );

  List<TechnicalSkill> _availableSoftSkills = [];
  List<TechnicalSkill> _availableTechnicalSkills = [];

  List<TechnicalSkill> _selectedSoftSkills = [];
  List<TechnicalSkill> _selectedTechnicalSkills = [];

  @override
  void initState() {
    super.initState();
    _skills = Skills.fromJson(widget.initialSkills.toJson());
    _selectedSoftSkills = List.from(_skills.softSkills ?? []);
    _selectedTechnicalSkills = List.from(_skills.technicalSkills ?? []);
    _availableSoftSkills = List.from(allSkills.softSkills ?? []);
    _availableTechnicalSkills = List.from(allSkills.technicalSkills ?? []);
  }

  void _removeSoftSkill(TechnicalSkill skill) {
    setState(() {
      _selectedSoftSkills.remove(skill);
    });
  }

  void _removeTechnicalSkill(TechnicalSkill skill) {
    setState(() {
      _selectedTechnicalSkills.remove(skill);
    });
  }

  void _saveSkills() {
    setState(() {
      _skills = Skills(
        softSkills: _selectedSoftSkills,
        technicalSkills: _selectedTechnicalSkills,
      );
    });
  }

  void _saveToBackend() {
    if (_selectedSoftSkills.isNotEmpty && _selectedTechnicalSkills.isNotEmpty) {
      final profile = context.read<ProfileCubit>().profile;
      profile!.skills = _skills;
      context.read<ProfileCubit>().updateProfile(profile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppBar(
            backBtn: true,
            backgroundColor: AppColors.primaryColor,
            title: 'المهارات',
          ),
        ),
        body: SingleChildScrollView(padding: const EdgeInsets.all(20), child: _buildEditView()),
      ),
    );
  }

  Widget _buildEditView() {
    return Column(
      children: [
        // Soft Skills Section
        Text(
          "المهارات الشخصية",
          style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        CustomDropdownButton<TechnicalSkill>(
          text: "المهارات الشخصية",
          items: _availableSoftSkills,
          itemToString: (skill) => skill.name ?? '',
          value: null,
          onChanged: (newValue) {
            if (newValue != null) {
              setState(() {
                _selectedSoftSkills.add(newValue);
              });
            }
          },
          selectedItems: _selectedSoftSkills,
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _selectedSoftSkills.map((skill) {
            return Chip(
              label: Text(skill.name ?? ''),
              backgroundColor: AppColors.primaryColor.withOpacity(0.2),
              deleteIcon: const Icon(Icons.close, size: 18),
              onDeleted: () => _removeSoftSkill(skill),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),

        // Technical Skills Section
        Text(
          "المهارات التقنية",
          style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        CustomDropdownButton<TechnicalSkill>(
          text: "اختر مهارة تقنية",
          items: _availableTechnicalSkills,
          itemToString: (skill) => skill.name ?? '',
          value: null, // Always reset after selection
          onChanged: (newValue) {
            if (newValue != null) {
              setState(() {
                _selectedTechnicalSkills.add(newValue);
              });
            }
          },
          selectedItems: _selectedTechnicalSkills,
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _selectedTechnicalSkills.map((skill) {
            return Chip(
              label: Text(skill.name ?? ''),
              backgroundColor: AppColors.primaryColor.withOpacity(0.2),
              deleteIcon: const Icon(Icons.close, size: 18),
              onDeleted: () => _removeTechnicalSkill(skill),
            );
          }).toList(),
        ),
        const SizedBox(height: 30),

        // Save to backend button
        BlocConsumer<ProfileCubit, ProfileState>(listener: (context, state) {
          if (state is UpdateProfileError) {
            CustomSnackBar.showSnackBar(
              context: context,
              title: "خطأ",
              message: state.message,
              contentType: ContentType.failure,
            );
          }
          if (state is UpdateProfileSuccess) {
            Navigator.pop(context);
            context.read<ProfileCubit>().getProfile();
            CustomSnackBar.showSnackBar(
              context: context,
              title: "تم الحفظ",
              message: "تم تحديث المهارات بنجاح",
              contentType: ContentType.success,
            );
          }
        }, builder: (context, state) {
          return CustomButton(
            isLoading: state is UpdateProfileLoading,
            onPressed: () {
              _saveSkills();
              _saveToBackend();
            },
            child: Text(
              "حفظ التغييرات",
              style: Styles.textStyle16.copyWith(color: Colors.white),
            ),
          );
        })
      ],
    );
  }
}
