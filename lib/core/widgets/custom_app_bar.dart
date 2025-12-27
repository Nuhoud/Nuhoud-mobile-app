import 'package:flutter/material.dart';

import '../utils/app_constats.dart';
import '../utils/styles.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key, required this.title, required this.backBtn, this.backgroundColor, this.textColor, this.actions});
  final String title;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget? actions;
  final bool backBtn;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: kHorizontalPadding + 4),
      decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white.withValues(alpha: 0.5),
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          backBtn
              ? IconButton(
                  icon: Icon(Icons.arrow_back_outlined, size: 20, color: textColor ?? Colors.white),
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
              style: Styles.textStyle18.copyWith(color: textColor ?? Colors.white, fontWeight: FontWeight.bold),
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
