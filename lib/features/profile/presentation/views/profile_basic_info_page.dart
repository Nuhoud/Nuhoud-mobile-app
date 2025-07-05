import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:nuhoud/features/profile/data/models/profile_model.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/widgets/custom_snak_bar.dart';
import '../../../../core/utils/size_app.dart';
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

  @override
  void initState() {
    super.initState();
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
      CustomSnackBar.showSnackBar(
        context: context,
        title: "خطأ",
        message: "الرجاء إدخال جميع البيانات",
        contentType: ContentType.failure,
      );
      return;
    }

    // final data = {
    //   "name": nameController.text.trim(),
    //   "gender": gender,
    //   "birthDate": dateController.text,
    //   "location": locationController.text.trim(),
    //   "languages": languages,
    // };

    //context.read<ProfileCubit>().updateProfile(data);

    CustomSnackBar.showSnackBar(
      context: context,
      title: "تم الحفظ",
      message: "تم تحديث الملف الشخصي بنجاح",
      contentType: ContentType.success,
    );
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
            title: 'المعلومات الشخصية',
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                SaveProfileButton(onPressed: _saveProfile),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
