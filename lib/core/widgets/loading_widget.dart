import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/app_colors.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Padding(
      padding: EdgeInsets.all(8.0),
      child: SizedBox(
        height: 20,
        width: 15,
        child: CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
      ),
    ));
  }
}
