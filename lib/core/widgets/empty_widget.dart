import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/app_colors.dart';
import 'package:nuhoud/core/utils/assets_data.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AssetsData.search,
            width: 200,
            height: 164,
          ),
          const SizedBox(height: 24),
          Text(
            "لا يوجد نتائج متاحة حاليا!",
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: AppColors.headingTextColor, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
