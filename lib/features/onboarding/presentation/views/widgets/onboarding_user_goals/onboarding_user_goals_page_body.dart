import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/utils/routs.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/utils/validation.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/custom_text_filed.dart';
import '../onboarding_container.dart';

class OnboardingUserGoalsPageBody extends StatefulWidget {
  const OnboardingUserGoalsPageBody({super.key});

  @override
  State<OnboardingUserGoalsPageBody> createState() =>
      _OnboardingUserGoalsPageBodyState();
}

class _OnboardingUserGoalsPageBodyState
    extends State<OnboardingUserGoalsPageBody> {
  late final TextEditingController goalController;
  late final List<TextEditingController> interestControllers = [
    TextEditingController()
  ];

  void _addInterestField() {
    setState(() {
      interestControllers.add(TextEditingController());
    });
  }

  void _removeInterestField(int index) {
    if (index == 0) return;
    interestControllers[index].dispose();
    setState(() {
      interestControllers.removeAt(index);
    });
  }

  @override
  void initState() {
    goalController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    goalController.dispose();
    for (var controller in interestControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  List<Widget> _buildInterestFields() {
    return List<Widget>.generate(interestControllers.length, (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: CustomTextField(
                text: "الاهتمام ${index + 1}",
                isPassword: false,
                validatorFun: (val) =>
                    Validator.validate(val, ValidationState.normal),
                hPadding: 0,
                controller: interestControllers[index],
                fillColor: Colors.white,
                prefixIcon: Icons.category,
              ),
            ),
            if (index > 0)
              IconButton(
                icon: const Icon(Icons.delete_outline_outlined,
                    color: Colors.red),
                onPressed: () => _removeInterestField(index),
              ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return OnBoardingContainer(
      withFixedHight: false,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "الاهداف المهنية",
              style: Styles.textStyle18.copyWith(color: AppColors.primaryColor),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              text: "الهدف",
              isPassword: false,
              maxLine: 3,
              validatorFun: (val) =>
                  Validator.validate(val, ValidationState.normal),
              hPadding: 0,
              controller: goalController,
              fillColor: Colors.white,
              prefixIcon: Icons.star_border_purple500_outlined,
            ),
            ..._buildInterestFields(),
            ElevatedButton.icon(
              onPressed: _addInterestField,
              icon: const Icon(Icons.add, color: Colors.white),
              label: Text(
                "إضافة اهتمام اخر",
                style: Styles.textStyle15.copyWith(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.skipButtonStartColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            CustomButton(
              child: Text("التالي",
                  style: Styles.textStyle16.copyWith(color: Colors.white)),
              onPressed: () => {
                GoRouter.of(context)
                    .push(Routers.kOndboardingJobPreferencesPage)
              },
            ),
          ],
        ),
      ),
    );
  }
}
