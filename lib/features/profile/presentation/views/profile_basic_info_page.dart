import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nuhoud/features/profile/data/models/profile_model.dart';
import 'package:nuhoud/features/profile/presentation/view-model/cubit/profile_cubit.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/widgets/custom_snak_bar.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import 'widgets/profile_basic_info_widgets.dart';

class ProfileBasicInfoPage extends StatefulWidget {
  final BasicInfo basicInfo;

  const ProfileBasicInfoPage({super.key, required this.basicInfo});
  @override
  State<ProfileBasicInfoPage> createState() => _ProfileBasicInfoPageState();
}

class _ProfileBasicInfoPageState extends State<ProfileBasicInfoPage> {
  late final TextEditingController locationController;
  late final TextEditingController dateController;
  late final TextEditingController languageController;
  final formKey = GlobalKey<FormState>();
  String? gender;
  List<String> languages = [];
  final ImagePicker _imagePicker = ImagePicker();
  String? _profilePhotoUrl;
  File? _localPhoto;

  @override
  void initState() {
    super.initState();
    _profilePhotoUrl = context.read<ProfileCubit>().profilePhotoUrl;
    locationController = TextEditingController(text: widget.basicInfo.location ?? '');
    dateController = TextEditingController(text: widget.basicInfo.dateOfBirth ?? '');
    gender = widget.basicInfo.gender;
    languages = List<String>.from(widget.basicInfo.languages ?? []);
    languageController = TextEditingController();
  }

  @override
  void dispose() {
    locationController.dispose();
    dateController.dispose();
    languageController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (formKey.currentState!.validate() && gender != null && languages.isNotEmpty) {
      if (context.read<ProfileCubit>().profile != null) {
        final data = BasicInfo(
          gender: gender,
          dateOfBirth: dateController.text,
          location: locationController.text.trim(),
          languages: languages,
        );
        final profile = context.read<ProfileCubit>().profile;
        profile?.basicInfo = data;
        context.read<ProfileCubit>().updateProfile(profile!);
      }
    } else {
      CustomSnackBar.showSnackBar(
        context: context,
        title: "خطأ",
        message: "الرجاء إدخال جميع البيانات",
        contentType: ContentType.failure,
      );
    }
  }

  void addLanguage() {
    final text = languageController.text.trim();
    if (text.isNotEmpty && !languages.contains(text)) {
      setState(() {
        languages.add(text);
        languageController.clear();
      });
    }
  }

  void removeLanguage(String lang) {
    setState(() => languages.remove(lang));
  }

  Future<void> _pickImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile == null) return;
    final file = File(pickedFile.path);
    setState(() => _localPhoto = file);
    if (mounted) context.read<ProfileCubit>().updateProfilePhoto(file);
  }

  Widget _buildProfilePhoto(ProfileState state) {
    final isUploading = state is UpdateProfilePhotoLoading;
    final hasLocalPhoto = _localPhoto != null;
    final hasRemotePhoto = _profilePhotoUrl != null;

    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey.shade200,
          child: hasLocalPhoto
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.file(_localPhoto!, fit: BoxFit.cover, width: 100, height: 100),
                )
              : hasRemotePhoto
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(_profilePhotoUrl!, fit: BoxFit.cover, width: 100, height: 100),
                    )
                  : const Icon(Icons.person_rounded, size: 52, color: AppColors.primaryColor),
        ),
        Positioned(
          bottom: 4,
          right: 4,
          child: InkWell(
            onTap: isUploading ? null : _pickImage,
            child: const CircleAvatar(
              radius: 13,
              backgroundColor: AppColors.primaryColor,
              child: Icon(Icons.edit, color: Colors.white, size: 14),
            ),
          ),
        ),
        if (isUploading)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.3),
              ),
              child: const Center(
                child: SizedBox(
                  height: 26,
                  width: 26,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is UpdateProfileSuccess) {
            Navigator.pop(context);
            context.read<ProfileCubit>().getProfile();
            CustomSnackBar.showSnackBar(
              context: context,
              title: "تم الحفظ",
              message: "تم تحديث الملف الشخصي بنجاح",
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
          if (state is UpdateProfilePhotoSuccess) {
            setState(() {
              _profilePhotoUrl = state.photoUrl;
              _localPhoto = null;
            });
            CustomSnackBar.showSnackBar(
              context: context,
              title: "تم الحفظ",
              message: "تم تحديث الصورة الشخصية بنجاح",
              contentType: ContentType.success,
            );
          }
          if (state is UpdateProfilePhotoError) {
            setState(() => _localPhoto = null);
            CustomSnackBar.showSnackBar(
              context: context,
              title: "خطأ",
              message: state.message,
              contentType: ContentType.failure,
            );
          }
        },
        child: Column(
          children: [
            const SafeArea(
              child: CustomAppBar(
                backBtn: true,
                backgroundColor: AppColors.primaryColor,
                title: 'المعلومات الشخصية',
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: BlocBuilder<ProfileCubit, ProfileState>(
                          buildWhen: (previous, current) =>
                              current is UpdateProfilePhotoLoading ||
                              current is UpdateProfilePhotoSuccess ||
                              current is UpdateProfilePhotoError,
                          builder: (context, state) => _buildProfilePhoto(state),
                        ),
                      ),
                      const SizedBox(height: 24),
                      DateOfBirthField(controller: dateController),
                      const SizedBox(height: 20),
                      LocationField(controller: locationController),
                      const SizedBox(height: 20),
                      GenderRadioGroup(gender: gender, onChanged: (value) => setState(() => gender = value)),
                      const SizedBox(height: 20),
                      LanguagesSection(
                        languages: languages,
                        removeLanguage: removeLanguage,
                        addLanguage: addLanguage,
                        languageController: languageController,
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                          return SaveProfileButton(onPressed: _saveProfile, isLoading: state is UpdateProfileLoading);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
