import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_constats.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    required this.backBtn,
  });
  final String title;
  final bool backBtn;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: kHorizontalPadding + 4),
      decoration: const BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          backBtn
              ? IconButton(
                  icon: const Icon(
                    Icons.arrow_back_outlined,
                    size: 20,
                    color: AppColors.backgroundColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              : const SizedBox(
                  height: 50,
                  width: 50,
                ),
          Flexible(
            child: Text(
              overflow: TextOverflow.ellipsis,
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 50,
            width: 50,
          ),
        ],
      ),
    );
  }
}
