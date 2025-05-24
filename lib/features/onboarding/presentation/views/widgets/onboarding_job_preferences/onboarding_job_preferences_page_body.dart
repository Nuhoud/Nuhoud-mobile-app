import 'package:flutter/material.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/utils/validation.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/custom_text_filed.dart';
import '../onboarding_container.dart';

class OnboardingJobPreferencesPageBody extends StatefulWidget {
  const OnboardingJobPreferencesPageBody({super.key});

  @override
  State<OnboardingJobPreferencesPageBody> createState() =>
      _OnboardingJobPreferencesPageBodyState();
}

class _OnboardingJobPreferencesPageBodyState
    extends State<OnboardingJobPreferencesPageBody> {
  final TextEditingController _locationController = TextEditingController();
  String? _selectedWorkPlaceType;
  String? _selectedJobType;

  final List<String> _workPlaceTypes = ['عن بعد', 'في الشركة', 'مزيج'];
  final List<String> _jobTypes = ['دوام كامل', 'دوام جزئي', 'عقد', 'مستقل'];

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
                  textAlign: TextAlign.center,
                  style: Styles.textStyle18
                      .copyWith(color: AppColors.primaryColor)),
            ),

            const SizedBox(height: 25),

            // Work Place Type Section
            Text("نوع مكان العمل", style: Styles.textStyle16),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _workPlaceTypes.map((type) {
                return ChoiceChip(
                  backgroundColor: Colors.white,
                  label: Text(type),
                  selected: _selectedWorkPlaceType == type,
                  onSelected: (selected) {
                    setState(() {
                      _selectedWorkPlaceType = selected ? type : null;
                    });
                  },
                  selectedColor: AppColors.primaryColor,
                  labelStyle: TextStyle(
                    color: _selectedWorkPlaceType == type
                        ? Colors.white
                        : Colors.black,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 25),

            // Job Type Section
            Text("نوع الوظيفة", style: Styles.textStyle16),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _jobTypes.map((type) {
                return ChoiceChip(
                  backgroundColor: Colors.white,
                  label: Text(type),
                  selected: _selectedJobType == type,
                  onSelected: (selected) {
                    setState(() {
                      _selectedJobType = selected ? type : null;
                    });
                  },
                  selectedColor: AppColors.primaryColor,
                  labelStyle: TextStyle(
                    color:
                        _selectedJobType == type ? Colors.white : Colors.black,
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
              validatorFun: (val) =>
                  Validator.validate(val, ValidationState.normal),
              isPassword: false,
            ),

            const SizedBox(height: 10),

            CustomButton(
              child: Text("التالي",
                  style: Styles.textStyle16.copyWith(color: Colors.white)),
              onPressed: () => {},
            ),
          ],
        ),
      ),
    );
  }
}
