import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nuhoud/core/utils/assets_data.dart';
import 'package:nuhoud/core/utils/routs.dart';
import 'package:nuhoud/features/home/presentation/view-model/home_cubit/home_cubit.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_constats.dart';
import '../../../../../core/utils/size_app.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const CustomHomeAppBar({super.key, required this.height});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return Container(
      color: AppColors.primaryColor,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: response(context, 55),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(kBorderRadius),
                    ),
                    child: TextField(
                      controller: searchController,
                      onSubmitted: (value) => _startSearsh(context, searchController),
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                            onPressed: () => _startSearsh(context, searchController),
                            icon: const Icon(Icons.search_outlined),
                            color: AppColors.primaryColor),
                        hintText: 'ابحث عن وظيفة',
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: response(context, 55),
                  height: response(context, 55),
                  decoration: BoxDecoration(
                    color: AppColors.textWhite.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: IconButton(
                      icon: Image.asset(
                        AssetsData.filter,
                        color: Colors.white,
                        width: response(context, 35),
                        height: response(context, 35),
                      ),
                      color: Colors.white,
                      onPressed: () {
                        GoRouter.of(context).push(Routers.kFilterPage);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _startSearsh(BuildContext context, TextEditingController searchController) {
    if (searchController.text.isEmpty) return;
    context.read<HomeCubit>().search = searchController.text;
    context.read<HomeCubit>().getJobs(loadMore: false);
    searchController.clear();
    context.read<HomeCubit>().search = null;
  }
}
