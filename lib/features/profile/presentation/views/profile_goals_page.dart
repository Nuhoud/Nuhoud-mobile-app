import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuhoud/core/utils/app_colors.dart';
import 'package:nuhoud/core/utils/enums.dart';
import 'package:nuhoud/core/utils/styles.dart';
import 'package:nuhoud/core/utils/validation.dart';
import 'package:nuhoud/core/widgets/custom_snak_bar.dart';
import 'package:nuhoud/core/widgets/custom_app_bar.dart';
import 'package:nuhoud/core/widgets/custom_button.dart';
import 'package:nuhoud/core/widgets/custom_text_filed.dart';
import 'package:nuhoud/features/profile/data/models/profile_model.dart';
import 'package:nuhoud/features/profile/presentation/view-model/cubit/profile_cubit.dart';

class ProfileGoalsPage extends StatefulWidget {
  final Goals initialGoals;

  const ProfileGoalsPage({
    super.key,
    required this.initialGoals,
  });

  @override
  State<ProfileGoalsPage> createState() => _ProfileGoalsPageState();
}

class _ProfileGoalsPageState extends State<ProfileGoalsPage> {
  late Goals _goals;
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _interestControllers = [];
  late TextEditingController _careerGoalController;

  @override
  void initState() {
    super.initState();
    _goals = Goals.fromJson(widget.initialGoals.toJson());
    _initializeControllers();
  }

  void _initializeControllers() {
    _careerGoalController = TextEditingController(text: _goals.careerGoal ?? '');

    // Initialize interest controllers
    _interestControllers.clear();
    for (var interest in _goals.interests ?? []) {
      _interestControllers.add(TextEditingController(text: interest));
    }
    // Ensure at least one interest field exists
    if (_interestControllers.isEmpty) {
      _interestControllers.add(TextEditingController());
    }
  }

  void _addInterestField() {
    setState(() {
      _interestControllers.add(TextEditingController());
    });
  }

  void _removeInterestField(int index) {
    if (_interestControllers.length > 1) {
      setState(() {
        _interestControllers[index].dispose();
        _interestControllers.removeAt(index);
      });
    }
  }

  void _saveGoals() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _goals.careerGoal = _careerGoalController.text.trim();
        _goals.interests =
            _interestControllers.map((controller) => controller.text.trim()).where((text) => text.isNotEmpty).toList();
      });
    }
  }

  void _saveToBackend() {
    if (_goals.careerGoal!.isNotEmpty && _goals.interests!.isNotEmpty) {
      final profile = context.read<ProfileCubit>().profile;
      profile!.goals = _goals;
      context.read<ProfileCubit>().updateProfile(profile);
    }
  }

  @override
  void dispose() {
    _careerGoalController.dispose();
    for (var controller in _interestControllers) {
      controller.dispose();
    }
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
              title: 'الأهداف والاهتمامات',
            ),
          ),
          Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(20), child: _buildEditForm())),
        ],
      ),
    );
  }

  Widget _buildEditForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Career Goal Field
          Text(
            "الهدف المهني:",
            style: Styles.textStyle18.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          CustomTextField(
            controller: _careerGoalController,
            maxLine: 3,
            hintText: "ما هو هدفك المهني؟",
            text: "الهدف المهني",
            isPassword: false,
            validatorFun: (val) => Validator.validate(val, ValidationState.normal),
          ),
          const SizedBox(height: 24),

          // Interests Section
          Text(
            "الاهتمامات:",
            style: Styles.textStyle18.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          ..._buildInterestFields(),
          ElevatedButton.icon(
            onPressed: _addInterestField,
            icon: const Icon(Icons.add, color: Colors.white),
            label: Text(
              "إضافة اهتمام جديد",
              style: Styles.textStyle15.copyWith(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 30),

          // Save to backend button
          BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state is UpdateProfileSuccess) {
                Navigator.pop(context);
                context.read<ProfileCubit>().getProfile();
                CustomSnackBar.showSnackBar(
                  context: context,
                  title: "تم الحفظ",
                  message: "تم تحديث الأهداف والاهتمامات بنجاح",
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
                onPressed: () {
                  _saveGoals();
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
      ),
    );
  }

  List<Widget> _buildInterestFields() {
    return List<Widget>.generate(_interestControllers.length, (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: _interestControllers[index],
                hintText: "الاهتمام ${index + 1}",
                text: "الاهتمام ${index + 1}",
                isPassword: false,
                hPadding: 0,
                prefixIcon: Icons.category,
                validatorFun: (val) {
                  // Only validate if it's the last field or all fields
                  if (index == _interestControllers.length - 1) {
                    return Validator.validate(val, ValidationState.normal);
                  }
                  return null;
                },
              ),
            ),
            if (_interestControllers.length > 1)
              IconButton(
                icon: const Icon(Icons.delete_outline_outlined, color: Colors.red),
                onPressed: () => _removeInterestField(index),
              ),
          ],
        ),
      );
    });
  }
}
