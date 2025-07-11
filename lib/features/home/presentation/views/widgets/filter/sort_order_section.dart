import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuhoud/core/shared/cubits/refresh_cubit/refresh_cubit.dart';
import 'package:nuhoud/core/utils/app_colors.dart';
import 'package:nuhoud/core/utils/services_locater.dart';
import 'package:nuhoud/core/utils/styles.dart';
import 'package:nuhoud/features/home/presentation/view-model/home_cubit/home_cubit.dart';

class SortOrderSection extends StatelessWidget {
  const SortOrderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    final refreshCubit = getit.get<RefreshCubit>();
    return BlocBuilder<RefreshCubit, RefreshState>(
      bloc: refreshCubit,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "فرز النتائج",
              style: Styles.textStyle16.copyWith(
                color: AppColors.headingTextColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text("من الأقدم"),
                    value: 'asc',
                    groupValue: homeCubit.filterSortOrder,
                    onChanged: (value) {
                      if (value != null) {
                        homeCubit.filterSortOrder = value;
                        refreshCubit.refresh();
                      }
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text("من الأحدث"),
                    value: 'desc',
                    groupValue: homeCubit.filterSortOrder,
                    onChanged: (value) {
                      if (value != null) {
                        homeCubit.filterSortOrder = value;
                        refreshCubit.refresh();
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}
