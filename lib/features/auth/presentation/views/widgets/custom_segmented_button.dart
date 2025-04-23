import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/app_localizations.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_constats.dart';
import '../../../../../core/utils/enums.dart';
import '../../../../../core/utils/styles.dart';

class CustomSegmentedButton extends StatelessWidget {
  final AuthType selectedAuthType;
  final ValueChanged<AuthType> onAuthTypeChanged;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  const CustomSegmentedButton({
    super.key,
    this.borderRadius = 10.0,
    this.padding,
    required this.selectedAuthType,
    required this.onAuthTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        segmentedButtonTheme: SegmentedButtonThemeData(
          style: _customButtonStyle(context),
        ),
      ),
      child: Padding(
        padding:
            padding ?? const EdgeInsets.symmetric(vertical: kVerticalPadding),
        child: SegmentedButton<AuthType>(
          style: const ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          segments: [
            ButtonSegment(
              value: AuthType.phone,
              label: Text('phone_num'.tr(context)),
            ),
            ButtonSegment(
              value: AuthType.email,
              label: Text('email'.tr(context)),
            ),
          ],
          selected: {selectedAuthType},
          onSelectionChanged: (Set<AuthType> newSelection) {
            onAuthTypeChanged(newSelection.first);
          },
        ),
      ),
    );
  }

  ButtonStyle _customButtonStyle(BuildContext context) {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          return states.contains(WidgetState.selected)
              ? AppColors.primaryColor.withValues(alpha: 0.2)
              : Colors.transparent;
        },
      ),
      foregroundColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          return states.contains(WidgetState.selected)
              ? AppColors.primaryColor
              : AppColors.secondaryText.withValues(alpha: 0.8);
        },
      ),
      side: WidgetStateProperty.resolveWith<BorderSide?>(
        (Set<WidgetState> states) {
          return const BorderSide(
            color: AppColors.secondaryText,
            width: 1.2,
          );
        },
      ),
      //side: WidgetStateProperty.all(OutlineInputBorder()),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(
        Styles.textStyle13.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      overlayColor: WidgetStateProperty.all(
        AppColors.primaryColor.withValues(alpha: 0.05),
      ),
    );
  }
}
