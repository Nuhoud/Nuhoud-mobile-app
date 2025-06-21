import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';

AppBar customAppBar(
    {required String text,
    void Function()? onPressed,
    required BuildContext context,
    bool centerTitle = false}) {
  return AppBar(
    centerTitle: centerTitle,
    elevation: 0,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    leading: Row(
      children: [
        const SizedBox(
          width: 7,
        ),
        CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.primaryColor,
          child: IconButton(
              onPressed: onPressed ??
                  () {
                    Navigator.pop(context);
                  },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 24,
                color: AppColors.textWhite,
              )),
        )
      ],
    ),
    title: Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.headingTextColor,
      ),
    ),
  );
}
