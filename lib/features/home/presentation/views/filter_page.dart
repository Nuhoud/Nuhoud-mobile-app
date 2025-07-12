import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/app_colors.dart';
import 'package:nuhoud/core/utils/size_app.dart';
import 'package:nuhoud/core/widgets/custom_app_bar.dart';
import 'package:nuhoud/features/home/presentation/views/widgets/filter/filter_page_body.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(response(context, 60)),
        child: const SafeArea(
          child: CustomAppBar(
            title: 'تصفية الوظائف',
            backBtn: true,
            backgroundColor: AppColors.primaryColor,
          ),
        ),
      ),
      body: const FilterPageBody(),
    );
  }
}
