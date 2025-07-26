import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuhoud/core/utils/app_colors.dart';
import 'package:nuhoud/core/utils/enums.dart';
import 'package:nuhoud/core/utils/styles.dart';
import 'package:nuhoud/core/utils/validation.dart';
import 'package:nuhoud/core/widgets/custom_app_bar.dart';
import 'package:nuhoud/core/widgets/custom_button.dart';
import 'package:nuhoud/core/widgets/custom_snak_bar.dart';
import 'package:nuhoud/core/widgets/custom_text_filed.dart';

import 'package:nuhoud/features/profile/data/models/profile_model.dart';
import 'package:nuhoud/features/profile/presentation/view-model/cubit/profile_cubit.dart';

class ProfileJobPreferencesPage extends StatefulWidget {
  final JobPreferences initialPreferences;

  const ProfileJobPreferencesPage({
    super.key,
    required this.initialPreferences,
  });

  @override
  State<ProfileJobPreferencesPage> createState() => _ProfileJobPreferencesPageState();
}

class _ProfileJobPreferencesPageState extends State<ProfileJobPreferencesPage> {
  late JobPreferences _preferences;
  bool _isEditing = false;
  final _locationController = TextEditingController();
  late List<String> _selectedWorkPlaceTypes;
  late List<String> _selectedJobTypes;

  final List<String> _workPlaceTypes = ['عن بعد', 'في الشركة', 'مزيج', 'الكل'];
  final List<String> _jobTypes = ['دوام كامل', 'دوام جزئي', 'عقد', 'مستقل', 'الكل'];

  @override
  void initState() {
    super.initState();
    _preferences = JobPreferences.fromJson(widget.initialPreferences.toJson());
    _selectedWorkPlaceTypes = List.from(_preferences.workPlaceType ?? []);
    _selectedJobTypes = List.from(_preferences.jobType ?? []);
    _locationController.text = _preferences.jobLocation ?? '';
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  void _startEditing() {
    setState(() {
      _isEditing = true;
    });
  }

  void _savePreferences() {
    setState(() {
      _preferences.workPlaceType = _selectedWorkPlaceTypes;
      _preferences.jobType = _selectedJobTypes;
      _preferences.jobLocation = _locationController.text;
      _isEditing = false;
    });
  }

  void _saveToBackend() {
    if (_selectedWorkPlaceTypes.isNotEmpty && _selectedJobTypes.isNotEmpty && _locationController.text.isNotEmpty) {
      final profile = context.read<ProfileCubit>().profile;
      profile!.jobPreferences = _preferences;
      context.read<ProfileCubit>().updateProfile(profile);
    }
  }

  void _updateWorkPlaceTypeSelection(String type, bool selected) {
    setState(() {
      if (type == 'الكل') {
        if (selected) {
          _selectedWorkPlaceTypes = _workPlaceTypes.where((t) => t != 'الكل').toList();
        } else {
          _selectedWorkPlaceTypes.clear();
        }
      } else {
        if (selected) {
          _selectedWorkPlaceTypes.add(type);
          // If all options except "الكل" are selected, auto-select "الكل"
          if (_selectedWorkPlaceTypes.length == _workPlaceTypes.length - 1) {
            _selectedWorkPlaceTypes = _workPlaceTypes.where((t) => t != 'الكل').toList();
          }
        } else {
          _selectedWorkPlaceTypes.remove(type);
        }
      }
    });
  }

  void _updateJobTypeSelection(String type, bool selected) {
    setState(() {
      if (type == 'الكل') {
        if (selected) {
          _selectedJobTypes = _jobTypes.where((t) => t != 'الكل').toList();
        } else {
          _selectedJobTypes.clear();
        }
      } else {
        if (selected) {
          _selectedJobTypes.add(type);
          // If all options except "الكل" are selected, auto-select "الكل"
          if (_selectedJobTypes.length == _jobTypes.length - 1) {
            _selectedJobTypes = _jobTypes.where((t) => t != 'الكل').toList();
          }
        } else {
          _selectedJobTypes.remove(type);
        }
      }
    });
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
            title: 'تفضيلات العمل',
          ),
        ),
        body: SingleChildScrollView(padding: const EdgeInsets.all(20), child: _buildEditForm() //: _buildDisplayView(),
            ),
        // floatingActionButton: _isEditing
        //     ? null
        //     : FloatingActionButton(
        //         onPressed: _startEditing,
        //         backgroundColor: AppColors.primaryColor,
        //         child: const Icon(Icons.edit, color: Colors.white),
        //       ),
      ),
    );
  }

  Widget _buildDisplayView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Work Place Type
        Text(
          "نوع مكان العمل:",
          style: Styles.textStyle18.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        if (_preferences.workPlaceType?.isNotEmpty ?? false)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _preferences.workPlaceType!.map((type) {
              return Chip(
                label: Text(type),
                backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                labelStyle: Styles.textStyle15.copyWith(color: AppColors.primaryColor),
              );
            }).toList(),
          )
        else
          Text(
            "لا توجد أنواع محددة",
            style: Styles.textStyle16.copyWith(color: Colors.grey),
          ),
        const SizedBox(height: 24),

        // Job Type
        Text(
          "نوع الوظيفة:",
          style: Styles.textStyle18.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        if (_preferences.jobType?.isNotEmpty ?? false)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _preferences.jobType!.map((type) {
              return Chip(
                label: Text(type),
                backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                labelStyle: Styles.textStyle15.copyWith(color: AppColors.primaryColor),
              );
            }).toList(),
          )
        else
          Text(
            "لا توجد أنواع محددة",
            style: Styles.textStyle16.copyWith(color: Colors.grey),
          ),
        const SizedBox(height: 24),

        // Job Location
        Text(
          "موقع العمل المفضل:",
          style: Styles.textStyle18.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        if (_preferences.jobLocation?.isNotEmpty ?? false)
          Text(
            _preferences.jobLocation!,
            style: Styles.textStyle16,
          )
        else
          Text(
            "لا يوجد موقع محدد",
            style: Styles.textStyle16.copyWith(color: Colors.grey),
          ),
      ],
    );
  }

  Widget _buildEditForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Work Place Type Section
        Text(
          "نوع مكان العمل",
          style: Styles.textStyle16.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _workPlaceTypes.map((type) {
            return ChoiceChip(
              backgroundColor: Colors.white,
              label: Text(type),
              selected: _selectedWorkPlaceTypes.contains(type),
              onSelected: (selected) => _updateWorkPlaceTypeSelection(type, selected),
              selectedColor: AppColors.primaryColor,
              labelStyle: TextStyle(
                color: _selectedWorkPlaceTypes.contains(type) ? Colors.white : Colors.black,
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 25),

        // Job Type Section
        Text(
          "نوع الوظيفة",
          style: Styles.textStyle16.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _jobTypes.map((type) {
            return ChoiceChip(
              backgroundColor: Colors.white,
              label: Text(type),
              selected: _selectedJobTypes.contains(type),
              onSelected: (selected) => _updateJobTypeSelection(type, selected),
              selectedColor: AppColors.primaryColor,
              labelStyle: TextStyle(
                color: _selectedJobTypes.contains(type) ? Colors.white : Colors.black,
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 25),
        // Job Location Field
        CustomTextField(
          controller: _locationController,
          text: "موقع العمل المفضل",
          prefixIcon: Icons.location_on_outlined,
          validatorFun: (val) => Validator.validate(val, ValidationState.normal),
          isPassword: false,
        ),
        const SizedBox(height: 30),
        // Save to backend button
        BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
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
                message: "تم تحديث تفضيلات العمل بنجاح",
                contentType: ContentType.success,
              );
            }
          },
          builder: (context, state) {
            return CustomButton(
              isLoading: state is UpdateProfileLoading,
              onPressed: () {
                _savePreferences();
                _saveToBackend();
              },
              child: Text(
                "حفظ التغييرات",
                style: Styles.textStyle16.copyWith(color: Colors.white),
              ),
            );
          },
        ),
      ],
    );
  }
}
