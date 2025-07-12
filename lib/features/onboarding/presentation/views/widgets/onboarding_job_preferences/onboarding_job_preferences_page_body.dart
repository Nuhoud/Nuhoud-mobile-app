import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/utils/routs.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/utils/validation.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/custom_snak_bar.dart';
import '../../../../../../core/widgets/custom_text_filed.dart';
import '../../../view-model/onboarding_cuibt/onboarding_cubit.dart';
import '../onboarding_container.dart';

class OnboardingJobPreferencesPageBody extends StatefulWidget {
  const OnboardingJobPreferencesPageBody({super.key});

  @override
  State<OnboardingJobPreferencesPageBody> createState() => _OnboardingJobPreferencesPageBodyState();
}

class _OnboardingJobPreferencesPageBodyState extends State<OnboardingJobPreferencesPageBody> {
  final TextEditingController _locationController = TextEditingController();
  List<String> _selectedWorkPlaceTypes = [];
  List<String> _selectedJobTypes = [];

  final List<String> _workPlaceTypes = ['عن بعد', 'في الشركة', 'مزيج', 'الكل'];
  final List<String> _jobTypes = ['دوام كامل', 'دوام جزئي', 'عقد', 'مستقل', 'الكل'];

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OnBoardingContainer(
      withFixedHight: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text("تفضيلات العمل",
                  textAlign: TextAlign.center, style: Styles.textStyle18.copyWith(color: AppColors.primaryColor)),
            ),

            const SizedBox(height: 25),
            // Work Place Type Section
            const Text("نوع مكان العمل", style: Styles.textStyle16),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _workPlaceTypes.map((type) {
                return ChoiceChip(
                  backgroundColor: Colors.white,
                  label: Text(type),
                  selected: _selectedWorkPlaceTypes.contains(type),
                  onSelected: (selected) {
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
                          if (_selectedWorkPlaceTypes.length == _workPlaceTypes.length - 1) {
                            _selectedWorkPlaceTypes = _workPlaceTypes.where((t) => t != 'الكل').toList();
                          }
                        } else {
                          _selectedWorkPlaceTypes.remove(type);
                        }
                      }
                    });
                  },
                  selectedColor: AppColors.primaryColor,
                  labelStyle: TextStyle(
                    color: _selectedWorkPlaceTypes.contains(type) ? Colors.white : Colors.black,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 25),

            // Job Type Section
            const Text("نوع الوظيفة", style: Styles.textStyle16),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _jobTypes.map((type) {
                return ChoiceChip(
                  backgroundColor: Colors.white,
                  label: Text(type),
                  selected: _selectedJobTypes.contains(type),
                  onSelected: (selected) {
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
                          // If all options except "الكل" are selected, select "الكل" too
                          if (_selectedJobTypes.length == _jobTypes.length - 1) {
                            _selectedJobTypes = _jobTypes.where((t) => t != 'الكل').toList();
                          }
                        } else {
                          _selectedJobTypes.remove(type);
                        }
                      }
                    });
                  },
                  selectedColor: AppColors.primaryColor,
                  labelStyle: TextStyle(
                    color: _selectedJobTypes.contains(type) ? Colors.white : Colors.black,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),

            // Job Location Field
            CustomTextField(
              text: "موقع العمل المفضل",
              hPadding: 20,
              controller: _locationController,
              prefixIcon: Icons.location_on_outlined,
              fillColor: Colors.white,
              validatorFun: (val) => Validator.validate(val, ValidationState.normal),
              isPassword: false,
            ),

            const SizedBox(height: 10),

            BlocConsumer<OnboardingCubit, OnboardingState>(
              listener: (context, state) {
                if (state is SaveUserInfoError) {
                  CustomSnackBar.showSnackBar(
                    context: context,
                    title: "خطأ",
                    message: state.message,
                    contentType: ContentType.failure,
                  );
                }
                if (state is SaveUserInfoSuccess) {
                  GoRouter.of(context).push(Routers.kOndboardingUserSkillsPage);
                }
              },
              builder: (context, state) {
                return CustomButton(
                  onPressed: () {
                    if (_selectedWorkPlaceTypes.isNotEmpty &&
                        _selectedJobTypes.isNotEmpty &&
                        _locationController.text.isNotEmpty) {
                      context.read<OnboardingCubit>().addUserInfo("jobPreferences", {
                        "workPlaceType": _selectedWorkPlaceTypes,
                        "jobType": _selectedJobTypes,
                        "jobLocation": _locationController.text
                      });
                      context.read<OnboardingCubit>().saveUserInfo();
                    } else {
                      CustomSnackBar.showSnackBar(
                        context: context,
                        title: "خطأ",
                        message: "الرجاء تعبئة جميع البيانات المطلوبة",
                        contentType: ContentType.failure,
                      );
                    }
                  },
                  isLoading: state is SaveUserInfoLoading,
                  child: Text("التالي", style: Styles.textStyle16.copyWith(color: Colors.white)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
