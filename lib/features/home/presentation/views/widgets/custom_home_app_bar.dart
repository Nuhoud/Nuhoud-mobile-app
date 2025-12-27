import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nuhoud/core/utils/assets_data.dart';
import 'package:nuhoud/core/utils/routs.dart';
import 'package:nuhoud/features/home/presentation/view-model/home_cubit/home_cubit.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_constats.dart';
import '../../../../../core/utils/size_app.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(AssetsData.logo, width: response(context, 50), height: response(context, 50)),
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: response(context, 45),
                          height: response(context, 45),
                          decoration: BoxDecoration(
                            color: AppColors.textWhite.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.notifications_outlined, color: Colors.white),
                        )),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: response(context, 45),
                      height: response(context, 45),
                      decoration: BoxDecoration(
                        color: AppColors.textWhite.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: IconButton(
                          icon: Image.asset(
                            AssetsData.filter,
                            color: Colors.white,
                            width: response(context, 25),
                            height: response(context, 25),
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
            const SizedBox(height: 16),
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
              ],
            ),
            const SizedBox(height: 16),
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
