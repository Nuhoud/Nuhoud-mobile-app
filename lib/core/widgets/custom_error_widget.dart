import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/app_colors.dart';
import 'package:nuhoud/core/utils/assets_data.dart';

import '../utils/app_constats.dart';
import '../utils/styles.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;
  final Color? backgroundColor;
  final Color? textColor;
  final String? retryButtonText;

  const CustomErrorWidget({
    super.key,
    required this.errorMessage,
    required this.onRetry,
    this.backgroundColor,
    this.textColor,
    this.retryButtonText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AssetsData.err,
            width: 200,
            height: 164,
          ),
          const SizedBox(height: kSizedBoxHeight),
          Text(
            errorMessage,
            style: Styles.textStyle18
                .copyWith(color: textColor ?? AppColors.headingTextColor, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: kSizedBoxHeight),
          ElevatedButton.icon(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: colorScheme.errorContainer,
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: kVerticalPadding),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            icon: const Icon(Icons.refresh_rounded),
            label: Text(retryButtonText ?? "اعادة المحاولة",
                style: Styles.textStyle16.copyWith(fontWeight: FontWeight.w600, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
